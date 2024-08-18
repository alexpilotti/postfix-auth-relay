import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

import sys

smtp_server = sys.argv[1]
smtp_port = int(sys.argv[2])
username = sys.argv[3]
password = sys.argv[4]

sender_email = username

recipient_email = sys.argv[5]

# Create the email content
subject = 'Test Email'
body = 'Test body'

msg = MIMEMultipart()
msg['From'] = sender_email
msg['To'] = recipient_email
msg['Subject'] = subject

msg.attach(MIMEText(body, 'plain'))

# Send the email
try:
    with smtplib.SMTP(smtp_server, smtp_port) as server:
        server.starttls()
        server.login(username, password)
        server.sendmail(sender_email, recipient_email, msg.as_string())
    print("Email sent successfully.")
except Exception as e:
    print(f"Failed to send email: {e}")
