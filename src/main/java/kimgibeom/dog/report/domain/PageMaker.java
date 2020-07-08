package kimgibeom.dog.report.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private int tempEndPage;
	private int prev;
	private int next;
	private int displayPageNum = 5;
	private Criteria cri;
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public int getTempEndPage() {
		return tempEndPage;
	}
	
	public Criteria getCri() {
		return cri;
	}
	 
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		if (endPage <= displayPageNum) {
			startPage = 1;
		} else startPage = (endPage - displayPageNum) + 1;
	
		tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		prev = cri.getPage() - 1;
		next = cri.getPage() + 1;
	}
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.build();
		   
		return uriComponents.toUriString();
	}
	
	public String makeSearch(int page) {
		UriComponents uriComponents =
            UriComponentsBuilder.newInstance()
            .queryParam("page", page)
            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
            .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
            .build(); 
	    return uriComponents.toUriString();  
	}

	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}
