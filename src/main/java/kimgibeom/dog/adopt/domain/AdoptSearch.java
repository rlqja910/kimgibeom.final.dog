package kimgibeom.dog.adopt.domain;

public class AdoptSearch extends AdoptPagination {
	private String searchType;

	public AdoptSearch() {
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
}
