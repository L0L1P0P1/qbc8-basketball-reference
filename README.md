# qbc8-basketball-reference
Welcome to the repository for our Data Scraping and Analysis project, developed as part of the Quera Data Analysis Bootcamp (QBC8). This project is a collaborative effort by Group 4, consisting of **Sahar Hannani**, **Behrad Badeli**, and **Milad Zeinali**, under the mentorship of **Parsa Behmanesh**.

Our project focuses on leveraging data scraping techniques to collect valuable datasets, followed by in-depth analysis to extract meaningful insights. This README provides an overview of the project, its objectives, methodologies, and how to navigate the repository.

# Setting Up Poetry for Python
This Project Uses Poetry for python dependency managements and virtual environments. Although you can achieve similar results by checking the required dependencies from `pyproject.toml` and installing them using pip or any other python package management software.

## Prerequisites

- Ensure that Python (version 3.7 or later) is installed on your system.
- Install `pip`, the Python package manager.

## 1. Installing Poetry Using pip

1. Open a terminal or command prompt.
2. Run the following command to install Poetry:

   ```bash
   pip install poetry
   ```

3. Verify the installation by checking the Poetry version:

   ```bash
   poetry --version
   ```

   If installed correctly, this command will display the installed Poetry version.

## 2. Installing Dependencies with Poetry

1. To install all dependencies specified in `pyproject.toml`, run:

   ```bash
   poetry install 
   ```

## 3. Entering the Poetry Virtual Environment

1. To activate the virtual environment managed by Poetry, run:

   ```bash
   poetry shell
   ```

   This opens a new shell session within the virtual environment.

   If this doesn't work for you for any reasons try:

   ```bash
   eval "$(poetry env activate)"
   ```

2. To exit the virtual environment, simply type:

   ```bash
   exit
   ```
