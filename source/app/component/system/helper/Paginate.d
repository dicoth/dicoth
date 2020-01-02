module app.component.system.helper.Paginate;
import std.conv;
class Paginate
{    
    this(string linkUrl, int nowPage = 1, int totalPageNum = 1, int blockNum = 10)
    {
        _linkUrl = linkUrl;            
        _nowPage = nowPage;            
        _totalPageNum = totalPageNum;  
        _blockNum = blockNum;          
    }

    public string showPages()
    {
        if(_totalPageNum <= 1) return "";
        import std.math;

        float temFval = ceil((cast(float)_blockNum)/2) ;
        int midPage = cast(int)temFval;

        string pagingStr = "";
        pagingStr ~= "<nav style=\"text-align:center\"><ul class=\"pagination\" ><input type=\"hidden\" name=\"page\" id=\"page\">";

        pagingStr ~= firstPage();  
        pagingStr ~= pageLast();  
        pagingStr ~= prePageBtn(midPage);  
        pagingStr ~= nextPageBtn(midPage); 
        pagingStr ~= pageNext();  
        pagingStr ~= endPage(); 

        pagingStr ~= "</ul></nav>";
        return pagingStr;
    }


    private string pageReplace(string page) 
    {
        import std.array;
        return _linkUrl.replace("{page}", page) ;
    }

    private string firstPage() 
    {
        return "<li class=\"page-item\" ><a class=\"page-link\" href='" ~ (1 != _nowPage ? pageReplace("1") : "javascript:;;") ~ "' aria-label='Previous'  title='Home'><span aria-hidden='true'>Home</span></a></li>";
    }

    
    private string endPage() 
    {
        return "<li class=\"page-item\" ><a class=\"page-link\" href='" ~ (_totalPageNum != _nowPage ? pageReplace(to!string(_totalPageNum))  : "javascript:;;") ~ "' aria-label='Previous'  title='End page'><span aria-hidden='true'>End page</span></a></li>";
    }

    private string pageLast() 
    {
        int page = _nowPage == 1 ? 1 : (_nowPage-1);
        return "<li class=\"page-item\" ><a class=\"page-link\" href='" ~ (page != _nowPage ? pageReplace(to!string(page)) : "javascript:;;") ~ "' aria-label='Previous'  title='previous'><span aria-hidden='true'>&laquo;</span></a></li>";

    }

    private string pageNext()
    {
        int page = (_nowPage== _totalPageNum ? _totalPageNum : (_nowPage+1) );
        return "<li class=\"page-item\" ><a class=\"page-link\" href='" ~ (page != _nowPage ? pageReplace(to!string(page)) : "javascript:;;") ~ "' aria-label='Next'  title='Next'><span aria-hidden='true'>&raquo;</span></a></li>";
    }

    private string prePageBtn(int midpage = 1)
    {
        string preBtnstr = "";
       
        int startIndex = _nowPage - midpage > 0? _nowPage - midpage : 1;
        startIndex = _totalPageNum-_nowPage > midpage || startIndex == 1 ? startIndex : _nowPage-(_blockNum-(_totalPageNum-_nowPage));
        startIndex = startIndex == 0 ? 1 : startIndex;
        int endIndex = _nowPage;

        for (int tem = startIndex ; tem < endIndex; tem=tem+1)
        {
            string css = "";
            if (tem == _nowPage)
            {
                css = "style=\"background-color:#00acd6;color:#FFFFFF;\" " ;
            }
            preBtnstr ~= "<li class=\"page-item\" ><a class=\"page-link\" " ~ css ~ " href=\" " ~ (tem != _nowPage ? pageReplace(to!string(tem)) : "javascript:;;") ~ "\"  > " ~ to!string(tem) ~ "</a></li>";
        }

        return preBtnstr;
    }

    private string nextPageBtn(int midpage = 1)
    {
        string nextBtnstr = "";
        int startIndex = _nowPage;
        int endIndex = (_blockNum - _nowPage > midpage ? _blockNum : (startIndex+midpage-1));
        endIndex = ( _totalPageNum-_nowPage < midpage || _nowPage == _totalPageNum ? _totalPageNum : endIndex );
        endIndex = endIndex > _totalPageNum ? _totalPageNum : endIndex;

        for (int tem = startIndex; tem <= endIndex; tem=tem+1)
        {
            string css = "";
            if (tem == _nowPage)
            {
                css = "style=\"background-color:#00acd6;color:#FFFFFF;\"" ;
            }
            nextBtnstr ~= "<li class=\"page-item\" ><a class=\"page-link\" " ~ css ~ " href=\" " ~ (tem != _nowPage ? pageReplace(to!string(tem)) : "javascript:;;") ~ "\" > " ~ to!string(tem) ~ "</a></li>";
        }
        return nextBtnstr;
    }

    private :
        int _blockNum;
        int _nowPage;
        int _totalPageNum;      
        string _linkUrl; 
     
}