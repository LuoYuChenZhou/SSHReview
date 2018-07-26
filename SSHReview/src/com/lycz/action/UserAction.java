package com.lycz.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.lycz.dao.UserDAO;
import com.lycz.design.CommonResult;
import com.lycz.design.Page;
import com.lycz.design.ToolUtil;
import com.lycz.entity.User;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import net.sf.json.JSONObject;

public class UserAction extends ActionSupport implements ModelDriven<User> {

	private User user = new User();// 使用modeldriven模式接收的参数必须要new
	private String searchName;
	private int curPage;
	private int pageSize;
	private String jsonStr;
	private String targetUrl;

	@Resource
	private UserDAO userDao;

	@Override
	public User getModel() {
		return user;
	}

	public String getSearchName() {
		return searchName;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getJsonStr() {
		return jsonStr;
	}

	public void setJsonStr(String jsonStr) {
		this.jsonStr = jsonStr;
	}

	public String getTargetUrl() {
		return targetUrl;
	}

	public void setTargetUrl(String targetUrl) {
		this.targetUrl = targetUrl;
	}

	public String login() {
		CommonResult<String> commonResult = new CommonResult<String>();
		commonResult.setData("");

		if (ToolUtil.isEmpty(userDao.findByExample(user))) {
			commonResult.setMsg("用户名或密码错误");
			commonResult.setStatus(401);
		} else {
			commonResult.setMsg("登录成功");
			commonResult.setStatus(200);
		}

		jsonStr = JSONObject.fromObject(commonResult).toString();

		return "complete";
	}

	public String getUserListByName() {
		curPage = curPage > 0 ? curPage : 1;
		pageSize = pageSize > 0 ? pageSize : 10;
		Page<User> page = userDao.getUserListByName(searchName, curPage, pageSize);
		jsonStr = JSONObject.fromObject(page).toString();
		return "complete";
	}

	public String deleteUser() {

		CommonResult<String> commonResult = new CommonResult<String>();
		commonResult.setData("");

		if (userDao.delete(user)) {
			commonResult.setMsg("删除成功");
			commonResult.setStatus(201);
		} else {
			commonResult.setMsg("删除失败");
			commonResult.setStatus(500);
		}

		jsonStr = JSONObject.fromObject(commonResult).toString();
		return "complete";
	}

	public String getUserInfoById() {

		User userInfo = userDao.findById(user.getId());
		if (ToolUtil.isEmpty(userInfo)) {
			return ERROR;
		}

		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("userInfo", userInfo);
		targetUrl ="/view/userEdit.jsp";
		return SUCCESS;
	}

	public String updateUser() {
		targetUrl ="/view/userList.jsp";
		return userDao.update(user) ? SUCCESS : ERROR;
	}
	
	public String addUser() {
		targetUrl ="/view/userList.jsp";
		return userDao.save(user) ? SUCCESS : ERROR;
	}
}
