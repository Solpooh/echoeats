package com.pofol.admin.product;

import lombok.Getter;

@Getter
public class PageHandler {
    private SearchProductAdminCondition sc;
    public  final int NAV_SIZE = 10; // page navigation size
    private int totalCnt; // 게시물의 총 갯수
    private int totalPage; // 전체 페이지의 갯수
    private int beginPage; // 화면에 보여줄 첫 페이지
    private int endPage; // 화면에 보여줄 마지막 페이지
    private boolean showNext = false; // 이후를 보여줄지의 여부. endPage==totalPage이면, showNext는 false
    private boolean showPrev = false; // 이전을 보여줄지의 여부. beginPage==1이 아니면 showPrev는 false

    public PageHandler(int totalCnt, Integer page) {
        this(totalCnt, new SearchProductAdminCondition(page, 10));
    }

    public PageHandler(int totalCnt, Integer page, Integer pageSize) {
        this(totalCnt, new SearchProductAdminCondition(page, pageSize));
    }

    public PageHandler(int totalCnt, SearchProductAdminCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        doPaging(totalCnt, sc);
    }

    private void doPaging(int totalCnt, SearchProductAdminCondition sc) {
        this.totalPage = totalCnt / sc.getPageSize() + (totalCnt % sc.getPageSize()==0? 0:1);
        this.sc.setPage(Math.min(sc.getPage(), totalPage));  // page가 totalPage보다 크지 않게
        this.beginPage = (this.sc.getPage() -1) / NAV_SIZE * NAV_SIZE + 1; // 11 -> 11, 10 -> 1, 15->11. 따로 떼어내서 테스트
        this.endPage = Math.min(beginPage + NAV_SIZE - 1, totalPage);
        this.showPrev = beginPage!=1;
        this.showNext = endPage!=totalPage;
    }

    void print() {
        System.out.println("page="+ sc.getPage());
        System.out.print(showPrev? "PREV " : "");

        for(int i=beginPage;i<=endPage;i++) {
            System.out.print(i+" ");
        }
        System.out.println(showNext? " NEXT" : "");
    }

    public void setSc(SearchProductAdminCondition sc) {
        this.sc = sc;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

	@Override
	public String toString() {
		return "PageHandler [sc=" + sc + ", NAV_SIZE=" + NAV_SIZE + ", totalCnt=" + totalCnt + ", totalPage="
				+ totalPage + ", beginPage=" + beginPage + ", endPage=" + endPage + ", showNext=" + showNext
				+ ", showPrev=" + showPrev + "]";
	}

}
