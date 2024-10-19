# BookMyRide
A traditional web application designed for vehicle service reservations, with a strong emphasis on security, authentication, and access control. 
This application specifically addresses security vulnerabilities identified in the OWASP Top 10, particularly focusing on mitigating Broken Access Control, SQL Injection, and Cross-Site Scripting (XSS).
User authentication and access control are implemented using OIDC (OpenID Connect) protocols, with Asgardeo serving as the cloud-based Identity Provider (IDP) for seamless authentication management.

## Steps to Deploy the Application

Download the Project: Start by downloading the project as a ZIP file.

- Extract the ZIP: Unzip the file and move it to your preferred workspace.

- Open in an IDE: Use an IDE that supports dynamic web application development, such as Eclipse, to open the project.

- Update Credentials: Navigate to src -> main -> webapp -> WEB-INF -> classes -> application.properties and input your credentials. Ensure you have an Asgardeo account, with an application set up and at least one user.

- Verify JAR Files: Confirm that essential JAR files such as json-simple and mysql-connector are available in the lib folder. If any are missing, download and add them to the project.

- Run the Application: Set index.jsp as the entry point and run the application on the Tomcat server. If you’re unfamiliar with how to configure and use Tomcat, refer to helpful YouTube tutorials for guidance.


### By following these steps, you can successfully deploy and run the application. Best of luck with your setup!
 [Find the Article about the application](https://medium.com/@supuniab1/developing-a-secure-vehicle-service-reservation-application-my-journey-with-bookmyride-df28b027d5c3)

