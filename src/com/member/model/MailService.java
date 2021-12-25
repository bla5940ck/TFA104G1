package com.member.model;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Properties;
import javax.mail.*;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

public class MailService {
	private final static String HOST = "smtp.gmail.com";
	private final static String AUTH = "true";
	private final static String PORT = "587";
	private final static String STARTTLE_ENABLE = "true";
	private final static String SENDER = "joylease2021@gmail.com";
	private final static String PASSWORD = "ipdlwxjblsnzettv";
	// 設定傳送郵件:至收信人的Email信箱,Email主旨,Email內容
	public void sendMail(String to, String subject, String messageText) {

		try {
			// 設定使用SSL連線至 Gmail smtp Server
			Properties props = new Properties();
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.auth", AUTH);
			props.put("mail.smtp.port", PORT);
			props.put("mail.smtp.starttls.enable", STARTTLE_ENABLE);
			props.put("mail.smtp.ssl.trust", HOST);
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			// ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
			// ●須將myGmail的【安全性較低的應用程式存取權】打開
//			final String myGmail = "joylease2021@gmail.com";
//			final String myGmail_password = "ipdlwxjblsnzettv";
//	      設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
			Authenticator authenticator = new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(SENDER, PASSWORD);
				}
			};

			Session session = Session.getDefaultInstance(props, authenticator);
			Message message = new MimeMessage(session);
//			設定寄件人、收件人、副本、主旨
			message.setSentDate(new Date());
			message.setHeader("Content-Type", "text/html; charset=UTF-8");
			message.setFrom(new InternetAddress(SENDER));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
//			message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(recipientCcs));
//          https://javaee.github.io/javamail/docs/api/javax/mail/internet/MimeUtility.html#encodeText-java.lang.String-java.lang.String-java.lang.String- (第三個參數參考API文件)
			message.setSubject(MimeUtility.encodeText(subject, StandardCharsets.UTF_8.toString(), "B"));

			//			first part (text)
			MimeBodyPart messageBody = new MimeBodyPart();
			messageBody.setContent(messageText, "text/html; charset=UTF-8");

			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBody);
			message.setContent(multipart);
			Transport transport = session.getTransport("smtp");
			try {
				transport.connect();
				transport.sendMessage(message, message.getAllRecipients());
			} finally {
				transport.close();
			}
			System.out.println("傳送成功!");
		} catch (MessagingException | UnsupportedEncodingException e) {
			System.out.println("傳送失敗!");
			e.printStackTrace();
		}
	}

//	 public static void main (String args[]){
//
//      String to = "joylease2021@gmail.com";
//      
//      String subject = "密碼通知";
//      
//      String ch_name = "David";
//      String passRandom = "111";
//      String messageText = "Hello! " + ch_name + " 請謹記此密碼: " + passRandom + "\n" +" (已經啟用)"; 
//       
//      MailService mailService = new MailService();
//      mailService.sendMail(to, subject, messageText);
//
//   }

}
