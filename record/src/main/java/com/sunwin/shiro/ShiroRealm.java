package com.sunwin.shiro;

import java.util.Collection;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.sunwin.sys.entity.User;
import com.sunwin.sys.utils.Const;

/**
 * 
 * 
 * <p>
 * Description: shiro授权类
 * </p>
 * 
 * @author 何培赟
 * @date 2018年6月21日
 */
public class ShiroRealm extends AuthorizingRealm {

	@Autowired
	private SessionDAO sessionDAO;

	// 授权
	@SuppressWarnings("unchecked")
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		System.out.println("4");
		Session session = SecurityUtils.getSubject().getSession();
		User user = (User) session.getAttribute("user");
		Set<String> permissions = (Set<String>) session.getAttribute(Const.PERMISSIONS);
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			if (permissions != null && permissions.size() > 0) {
				info.addStringPermissions(permissions);
				System.out.println("2");
				return info;
			} else {
				return null;
			}
		} else {
			System.out.println("无权进行此操作");
		}
		return null;
	}

	// 登陆
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		System.out.println("3");
		String username = (String) token.getPrincipal();
		String password = new String((char[]) token.getCredentials());
		UsernamePasswordToken upt = (UsernamePasswordToken) token;
		String loginName=((UsernamePasswordToken) token).getUsername();
		// 获取已登录的用户
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		for (Session session : sessions) {
			// 如果此时登录用户已经登录
			if (loginName.equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)))) {
				session.setTimeout(0);// 设置session立即失效，即将其踢出系统
				break;
			}
		}
		if (upt.getUsername() != null & password != null) {
			System.out.println("1");
			return new SimpleAuthenticationInfo(username, password, getName());
		} else {
			throw new AuthenticationException();
		}
	}

}
