package com.lycz.design;

import java.util.List;

public class Page<T> {
	private int curPage;
	private int pageSize;
	private List<T> data;
	private String msg;
	private int status;
	private long count;
	private long totalPage;
	private boolean hasPrePage;
	private boolean hasNextPage;

	public Page(int curPage, int pageSize, List<T> data, long count) {
		super();
		this.curPage = curPage;
		this.pageSize = pageSize;
		this.data = data;
		this.count = count;
		this.msg = ToolUtil.isEmpty(data) ? "查询结束，但没有数据" : "查询成功";
		this.status = ToolUtil.isEmpty(data) ? 204 : 200;
		this.totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;
		this.hasPrePage = this.curPage > 1;
		this.hasNextPage = this.totalPage > 0 && this.curPage < this.totalPage;
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

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public boolean isHasPrePage() {
		return hasPrePage;
	}

	public void setHasPrePage(boolean hasPrePage) {
		this.hasPrePage = hasPrePage;
	}

	public boolean isHasNextPage() {
		return hasNextPage;
	}

	public void setHasNextPage(boolean hasNextPage) {
		this.hasNextPage = hasNextPage;
	}

}
