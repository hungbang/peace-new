package com.vn.hungtq.peace.entity;
 

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Country generated by hbm2java
 */
@Entity
@Table(name = "country")
public class Country implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7829951606666445239L;
	private Integer id;
	private CountryGroup countryGroup;
	private String name;
	private Set<CountryUserMap> countryUserMaps = new HashSet<CountryUserMap>(0);

	public Country() {
	}

	public Country(CountryGroup countryGroup, String name) {
		this.countryGroup = countryGroup;
		this.name = name;
	}

	public Country(CountryGroup countryGroup, String name, Set<CountryUserMap> countryUserMaps) {
		this.countryGroup = countryGroup;
		this.name = name;
		this.countryUserMaps = countryUserMaps;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "country_group_id", nullable = false)
	public CountryGroup getCountryGroup() {
		return this.countryGroup;
	}

	public void setCountryGroup(CountryGroup countryGroup) {
		this.countryGroup = countryGroup;
	}

	@Column(name = "name", nullable = false, length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "country")
	public Set<CountryUserMap> getCountryUserMaps() {
		return this.countryUserMaps;
	}

	public void setCountryUserMaps(Set<CountryUserMap> countryUserMaps) {
		this.countryUserMaps = countryUserMaps;
	}

}