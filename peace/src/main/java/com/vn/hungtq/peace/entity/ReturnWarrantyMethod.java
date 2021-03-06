package com.vn.hungtq.peace.entity;
 

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * ReturnWarrantyMethod generated by hbm2java
 */
@Entity
@Table(name = "return_warranty_method")
public class ReturnWarrantyMethod implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6517979160069164688L;
	private Integer id;
	private String name;

	public ReturnWarrantyMethod() {
	}

	public ReturnWarrantyMethod(String name) {
		this.name = name;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "name", nullable = false, length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
