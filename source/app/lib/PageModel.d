module app.lib.PageModel;

import hunt.logging;
import hunt.entity.domain.Page;

struct PageModel
{
    int previous;
    int current;
    int next;
    int[] pages;
    int size;
    long totalElements;
    int totalPages;
}

PageModel GenaratePageData(T)(Page!T page, int current = 1)
{
    PageModel p;

    p.current = page.getNumber();

    if (page.hasNextPage())
    {
        p.next = page.getNumber() + 1;
    }

    if (page.hasPreviousPage())
    {
        p.previous = page.getNumber() - 1;
    }

    p.size = page.getSize();
    p.totalPages = page.getTotalPages();
    p.totalElements = page.getTotalElements();

    int pageStart = 1;
    int pageEnd = page.getTotalPages();

    if (page.getNumber() > 5)
    {
        pageStart = page.getNumber() - 2;
    }

    if (page.getTotalPages() - 5 > page.getNumber())
    {
        pageEnd = page.getNumber() + 2;
    }

    int[] pages;

    p.pages = (page.getNumber() < 2) ? [1] : pages[pageStart .. pageEnd];

    return p;
}
