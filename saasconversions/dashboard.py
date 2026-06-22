import streamlit as st
import pandas as pd
from pathlib import Path

current_dir = Path(__file__).parent if "__file__" in locals() else Path.cwd()

st.title("SaaS Conversion Dashboard")
st.write("User conversion and churn metrics")

conversions_path = current_dir / "fctconversions.csv"
users_path = current_dir / "dimusers.csv"

conversions = pd.read_csv(conversions_path)
users = pd.read_csv(users_path)

st.subheader("Conversion Metrics by Month")
st.bar_chart(conversions, x="signup_month", y="converted_users")

st.subheader("Churn by Month")
st.line_chart(conversions, x="signup_month", y="churned_users")

st.subheader("Average Usage by Plan")
usage = users.groupby("plan_type")["usage_count"].mean().reset_index()
st.bar_chart(usage, x="plan_type", y="usage_count")

st.subheader("Monthly Data")
st.dataframe(conversions)