package com.mercury.ticket.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.User;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

@Service
@Transactional
public class UserService {
	final static String sub = " :welcome to use Ticket system";
	final static String auto = " this is an automatic email,please do not reply,\n Thanks";
	final static String back=" welcome back to ticket system";
	@Autowired
	@Qualifier("userDao")
	private HibernateDao<User, Integer> hd;

	@Autowired
	private MailService ms;

	public MailService getMailService() {
		return ms;
	}

	public void setMailService(MailService ms) {
		this.ms = ms;
	}

	public HibernateDao<User, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<User, Integer> hd) {
		this.hd = hd;
	}

	// **********user service***********//
	public List<User> getAllUsers() {
		return hd.findAll();
	}

	public User updateUser(User user) {
		hd.save(user);
		return user;
	}

	// 1-user service
	public User findUser(String username) {
		return hd.findBy("username", username);
	}

	// 1-find user by pass for email only
	public User findUserByPass(String password) {
		return hd.findBy("password", password);
	}

	// not used
	public String enPassword(String password) {
		return null;
	}

	// 2-add new users
	public User addNewUser(String username, String password) {
		User newu = new User();
		if(emailValid(username)){
		newu.setUsername(username);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String hp = encoder.encode(password);
	//	System.out.println(hp+" :"+hp.length());//
		newu.setPassword(hp);
		this.updateUser(newu);
		return newu;
		}else return null;
	}

	private boolean emailValid(String username) {
		boolean isvalid = false;
		try {
			InternetAddress internetadd = new InternetAddress(username);
			internetadd.validate();
			isvalid = true;
		} catch (AddressException e) {
			// System.out.println("error");
		}
		return isvalid;
	}

	// 3- send automatic emails
//	public void sendEmail(String username) {
//		
//		ms.sendMail(username, username + sub, body);		
//	}

	// 3-send login auto emails
	public void sendLoginEmail(String username,String role) {
		
	ms.sendMail(username, role+username + back,auto);		
	}

//	3-send verify emails for register
public void sendVerifyEmail(String username){
		
		String salt = BCrypt.gensalt(12);
		String hash = BCrypt.hashpw(username, salt);
		String body = "http://192.168.1.112:8080/Ticket/success.html?username_id="
				+ username+"&key="+hash;
		ms.sendMail(username, username + sub, body+"\n"+auto);
	}
      //3-email verify
	public boolean emailVerify(String username,String key){
		boolean flag = BCrypt.checkpw(username, key);
		User user=null;
		if(flag){
		String authority = "USER_ADMIN";// set authority for users		
		user = this.findUser(username);
		user.setEnable(1);
		user.setAuthority(authority);
		this.updateUser(user);
		return true;
		}
		else return false;		
	}
	
	private boolean luhnTest(String number) {
		int s1 = 0, s2 = 0;
		String reverse = new StringBuffer(number).reverse().toString();
		for (int i = 0; i < reverse.length(); i++) {
			int digit = Character.digit(reverse.charAt(i), 10);
			if (i % 2 == 0) {
				// this is for odd digits, they are 1-indexed in the algorithm
				s1 += digit;
			} else {
				// add 2 * digit for 0-4, add 2 * digit - 9 for 5-9
				s2 += 2 * digit;
				if (digit >= 5) {
					s2 -= 9;
				}
			}
		}
		return (s1 + s2) % 10 == 0;
	}

	// 4-verify card number
	public boolean cardValid(String accountnum) {
		if (luhnTest(accountnum)) {
			return true;
		} else {
			return false;
		}
	}

	// 5-set card info
	public User setCardInfo(String username, String accountnum,
			String expiredate, String accountname, int sn) {
		User user = this.findUser(username);
		user.setAccountname(accountname);
		user.setAccountnum(accountnum);
		user.setExpiredate(expiredate);
		user.setSn(sn);
		this.updateUser(user);
		return user;
	}

	// 6-set user info
	public User setUserInfo(String username, String firstname, String lastname,
			String phone, String address) {
		User user = this.findUser(username);
		user.setFirstname(firstname);
		user.setLastname(lastname);
		user.setPhone(phone);
		user.setAddress(address);
		this.updateUser(user);
		return user;
	}
}
