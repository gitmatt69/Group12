# Group 12 Semester Project - Web-Based Supply Chain Application
This is a repo for a web-based application for a University project for the module BFB 321. This is the submission for the semester project for Group 12.

## Group members
Matthew Taylor, u23739772  
Daniël Johannes Voges, u23539519  
Etienne Kros, u23628911  
Chris-Dian Haasbroek, u05017158

## Project Purpose
The objective and purpose of this project is to improve VanH's operational efficeincy by means of improving data commmunication and system visibility. This is achieved by constructing and implementing a web-based Sales and Operations Planning (S&OP) platform for the business to replace the currently used manual, paper-based data communication system. This platform will effectively execute various supply chain management functions such as centralised data communication, optimising order cycle times, comprehensive inventory tracking and improving overall prodcuction quality. (We can stop here, the rest is just expansion)

Centralised data communication will improve day-to-day logistics and manufacturing operations by promoting process transparency to all parties that it may concern and effective communication between employees and managers. Inventory tracking enables inventory visbility which allows VanH to minimise its material handling expenses while sustaining maximum client service levels and avoiding stock-outs. The system highlights supply chain bottlenecks and underutilised proceses that may serve as potential alleviator which reduces the aggregate cycle time of orders. Production quality is improved by granting VanH strict supervision on product standards and enabling the business to study defective products to determine their root causes and take action. 

Once the web-based S&OP platform has been constructed it is enrolled integrated into VanH's operations to replace the current manual paper-based data communication system and thereby improve overall operational efficiency.

## File Structure 
![file_structure](https://github.com/user-attachments/assets/ff9550c1-b3b1-4505-9a64-c07e60c0b79b)


## Entity Realtionship Diagram (ERD)
![bfb_erd](https://github.com/user-attachments/assets/3f3426a5-f8c3-4f88-9ad1-bf38cb00faff)


## Running the App
The following steps are required to ensure that the constructed inventory management app runs effectively and without any errors.
Please ensure to use Google Chrome to run the app, as we have had issues with Microsoft Edge and our CSS/styling. 
### Step 1: Clone the repository
Open VS Code and do either of the following: 
Press Ctrl Shift P and then use the following (Ensure you select Group 12 after typing this)
```
Git: Clone
```
OR type in a terminal the following: 
```
git clone https://github.com/gitmatt69/Group12
cd Group12
```

### Step 2: Create a virtual environment
Ensure that the latest version of Python is installed. (This is version 3.14.0 at the time of writing)
Type in a terminal:
```
python -m venv venv
```
Then use one of the folliwng depending on your machine:
Windows (Command Prompt):
``` 
venv\Scripts\activate
```
Windows (PowerShell):
```
.\venv\Scripts\Activate.ps1
```
Mac/Linux:
```
source venv/bin/activate
```
To download Flask, type in the terminal:
```
pip install Flask
```
### Step 3: Initialise the database
Open the inventory.sql file in VS Code. Then do the following: 
Press Ctrl Shift P and select the following (Ensure no code is highlighted so all the tables are created and all data is inserted)
```
SQLite: Run Query
```
OR open a terminal/command prompt and run the following:
```
sqlite3 inventory.db < inventory.sql
```
You should now have a working database! 
### Step 4: Running the app
If you created a virtual environment, use the following in a terminal:
```
flask run
```
Then the app will open at the following (Use Google Chrome) 
```
http://127.0.0.1:5000
```
If you did not create a virtual environment, use the following in a terminal:
```
python app.py
```
It will open at the following (Use Google Chrome)
```
http://127.0.0.1:5000  
```
