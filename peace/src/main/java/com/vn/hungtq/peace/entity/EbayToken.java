package com.vn.hungtq.peace.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;


/**
 * The persistent class for the ebay_token database table.
 * 
 */
@Entity
@Table(name="ebay_token")
@NamedQuery(name="EbayToken.findAll", query="SELECT e FROM EbayToken e")
public class EbayToken implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="token_id")
	private int tokenId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="create_date")
	private Date createDate;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="expires_date")
	private Date expiresDate;

	@Lob
	private String token;

	@Column(name="user_id")
	private Integer userId;

	public EbayToken() {
	}

	public int getTokenId() {
		return this.tokenId;
	}

	public void setTokenId(int tokenId) {
		this.tokenId = tokenId;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getExpiresDate() {
		return this.expiresDate;
	}

	public void setExpiresDate(Date expiresDate) {
		this.expiresDate = expiresDate;
	}

	public String getToken() {
		return this.token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

}