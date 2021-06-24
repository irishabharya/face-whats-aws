def mail(to, text):
    import smtplib  
    server = smtplib.SMTP_SSL( "smtp.gmail.com", 465 )
    server.login( "ri**********@gmail.com", "password" )
    server.sendmail( "**************@gmail.com", to, text )
    server.quit()