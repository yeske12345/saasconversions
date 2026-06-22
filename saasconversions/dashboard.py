import streamlit as st
import pandas as pd
import duckdb
import os

st.title("SaaS Conversion Dashboard")
st.write("User conversion and churn metrics")

db_path = os.path.join(os.path.dirname(__file__), "analytics.duckdb")
con = duckdb.connect(db_path)

df = con.execute("SELECT * FROM fctconversions ORDER BY signup_month").fetchdf()

st.subheader("Conversion Metrics by Month")
st.bar_chart(df, x="signup_month", y="converted_users")

st.subheader("Churn by Month")
st.line_chart(df, x="signup_month", y="churned_users")

st.subheader("Average Usage by Plan")
usage = con.execute("SELECT plan_type, AVG(usage_count) as avg_usage FROM dimusers GROUP BY plan_type").fetchdf()
st.bar_chart(usage, x="plan_type", y="avg_usage")

st.subheader("Raw Data")
st.dataframe(df)