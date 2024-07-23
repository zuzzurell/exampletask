# Deel Home Task - dbt Project

Welcome to the Deel Home Task dbt project! This project is designed to model and analyze Globepay transaction data. Follow the instructions below to set up and run the project.

## Repository Access

If needed, reach out for access to the repository:
[Deel Home Task GitHub Repository](https://github.com/zuzzurell/deel_home_task.git)

## Cloning the Repository

Clone the repository to your local machine using the following command:

```bash
git clone https://github.com/zuzzurell/deel_home_task.git
```

##  Setup Instructions
1. Add Snowflake Password to Environment Variables
Add the Snowflake password to your environment variables by updating your .zshrc file. Open .zshrc.

The Snowflake password needs to be provided (will be attached in the mail with the test)

In your favorite text editor and add the following line:

```bash
export DBT_PASSWORD_DEEL=your_snowflake_password_here
```
Replace your_snowflake_password_here with your actual Snowflake password. Save the file and then reload your .zshrc with:

```bash
source ~/.zshrc
```
2. Setting Up the Environment
If you do not have a dedicated environment for this project, you can create one using Conda and install the necessary packages. Follow these steps:

Install Conda (if you don't already have it):

Download and install Conda from the official website.
Create a Virtual Environment:

```bash
conda create -n deel_home_task python=3.9
```
Activate the Virtual Environment:

```bash
conda activate deel_home_task
```
Install dbt and Snowflake Adapter:

```bash
pip install dbt-snowflake
```

3. Install dbt
If you haven't installed dbt, you can do so using pip:

```bash
pip install dbt
```

4. Build the dbt Project
Run the following command to build the dbt project and execute all models:

```bash
dbt build
```
5. Viewing Documentation
To generate and view the dbt documentation, run the following commands:

Generate Documentation:

```bash
dbt docs generate
```
Serve Documentation Locally:

```bash
dbt docs serve
```

After running this command, open your web browser and go to the URL provided in the terminal output to view the documentation.

Additional Information
Models: The project contains models to answer specific business questions related to Globepay transaction data.
Documentation: Each model and column is documented to provide clarity on its purpose and details.