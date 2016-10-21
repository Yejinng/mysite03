package com.bit2016.mysite.vo;

public class BoardVo {

	private Long no;
	private String title;
	private String content;
	private String regDate;
	private Integer hit;
	private Integer groupNo;
	private Integer orderNo;
	private Integer depth;
	private Long userNo;
	private String userName;
	public Long getNo() {
		return no;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getRegDate() {
		return regDate;
	}
	public Integer getHit() {
		return hit;
	}
	public Integer getGroupNo() {
		return groupNo;
	}
	public Integer getOrderNo() {
		return orderNo;
	}
	public Integer getDepth() {
		return depth;
	}
	public Long getUserNo() {
		return userNo;
	}
	public String getUserName() {
		return userName;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	public void setGroupNo(Integer groupNo) {
		this.groupNo = groupNo;
	}
	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	public void setDepth(Integer depth) {
		this.depth = depth;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@Override
	public String toString() {
		return "BoardVo [no=" + no + ", title=" + title + ", content=" + content + ", regDate=" + regDate + ", hit="
				+ hit + ", groupNo=" + groupNo + ", orderNo=" + orderNo + ", depth=" + depth + ", userNo=" + userNo
				+ ", userName=" + userName + "]";
	}
	
}
