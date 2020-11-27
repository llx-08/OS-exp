// #include <pmm.h>
// #include <list.h>
// #include <string.h>
// #include <default_pmm.h>
//
// /*  In the First Fit algorithm, the allocator keeps a list of free blocks
//  * (known as the free list). Once receiving a allocation request for memory,
//  * it scans along the list for the first block that is large enough to satisfy
//  * the request. If the chosen block is significantly larger than requested, it
//  * is usually splitted, and the remainder will be added into the list as
//  * another free block.
//  *  Please refer to Page 196~198, Section 8.2 of Yan Wei Min's Chinese book
//  * "Data Structure -- C programming language".
// */
// // LAB2 EXERCISE 1: YOUR CODE
// // you should rewrite functions: `default_init`, `default_init_memmap`,
// // `default_alloc_pages`, `default_free_pages`.
// /*
//  * Details of FFMA
//  * (1) Preparation:
//  *  In order to implement the First-Fit Memory Allocation (FFMA), we should
//  * manage the free memory blocks using a list. The struct `free_area_t` is used
//  * for the management of free memory blocks.
//  *  First, you should get familiar with the struct `list` in list.h. Struct
//  * `list` is a simple doubly linked list implementation. You should know how to
//  * USE `list_init`, `list_add`(`list_add_after`), `list_add_before`, `list_del`,
//  * `list_next`, `list_prev`.
//  *  There's a tricky method that is to transform a general `list` struct to a
//  * special struct (such as struct `page`), using the following MACROs: `le2page`
//  * (in memlayout.h), (and in future labs: `le2vma` (in vmm.h), `le2proc` (in
//  * proc.h), etc).
//  * (2) `default_init`:
//  *  You can reuse the demo `default_init` function to initialize the `free_list`
//  * and set `nr_free` to 0. `free_list` is used to record the free memory blocks.
//  * `nr_free` is the total number of the free memory blocks.
//  * (3) `default_init_memmap`:
//  *  CALL GRAPH: `kern_init` --> `pmm_init` --> `page_init` --> `init_memmap` -->
//  * `pmm_manager` --> `init_memmap`.
//  *  This function is used to initialize a free block (with parameter `addr_base`,
//  * `page_number`). In order to initialize a free block, firstly, you should
//  * initialize each page (defined in memlayout.h) in this free block. This
//  * procedure includes:
//  *  - Setting the bit `PG_property` of `p->flags`, which means this page is
//  * valid. P.S. In function `pmm_init` (in pmm.c), the bit `PG_reserved` of
//  * `p->flags` is already set.
//  *  - If this page is free and is not the first page of a free block,
//  * `p->property` should be set to 0.
//  *  - If this page is free and is the first page of a free block, `p->property`
//  * should be set to be the total number of pages in the block.
//  *  - `p->ref` should be 0, because now `p` is free and has no reference.
//  *  After that, We can use `p->page_link` to link this page into `free_list`.
//  * (e.g.: `list_add_before(&free_list, &(p->page_link));` )
//  *  Finally, we should update the sum of the free memory blocks: `nr_free += n`.
//  * (4) `default_alloc_pages`:
//  *  Search for the first free block (block size >= n) in the free list and reszie
//  * the block found, returning the address of this block as the address required by
//  * `malloc`.
//  *  (4.1)
//  *      So you should search the free list like this:
//  *          list_entry_t le = &free_list;
//  *          while((le=list_next(le)) != &free_list) {
//  *          ...
//  *      (4.1.1)
//  *          In the while loop, get the struct `page` and check if `p->property`
//  *      (recording the num of free pages in this block) >= n.
//  *              struct Page *p = le2page(le, page_link);
//  *              if(p->property >= n){ ...
//  *      (4.1.2)
//  *          If we find this `p`, it means we've found a free block with its size
//  *      >= n, whose first `n` pages can be malloced. Some flag bits of this page
//  *      should be set as the following: `PG_reserved = 1`, `PG_property = 0`.
//  *      Then, unlink the pages from `free_list`.
//  *          (4.1.2.1)
//  *              If `p->property > n`, we should re-calculate number of the rest
//  *          pages of this free block. (e.g.: `le2page(le,page_link))->property
//  *          = p->property - n;`)
//  *          (4.1.3)
//  *              Re-caluclate `nr_free` (number of the the rest of all free block).
//  *          (4.1.4)
//  *              return `p`.
//  *      (4.2)
//  *          If we can not find a free block with its size >=n, then return NULL.
//  * (5) `default_free_pages`:
//  *  re-link the pages into the free list, and may merge small free blocks into
//  * the big ones.
//  *  (5.1)
//  *      According to the base address of the withdrawed blocks, search the free
//  *  list for its correct position (with address from low to high), and insert
//  *  the pages. (May use `list_next`, `le2page`, `list_add_before`)
//  *  (5.2)
//  *      Reset the fields of the pages, such as `p->ref` and `p->flags` (PageProperty)
//  *  (5.3)
//  *      Try to merge blocks at lower or higher addresses. Notice: This should
//  *  change some pages' `p->property` correctly.
//  */
//
// // ？？并没有在list.h里找到这个的结构
// free_area_t free_area;
//
// #define free_list (free_area.free_list)     //空闲块的头
// #define nr_free (free_area.nr_free) // 空闲块的总数
//
// /*
//  * (2) `default_init`:
//  *  You can reuse the demo `default_init` function to initialize the `free_list`
//  * and set `nr_free` to 0. `free_list` is used to record the free memory blocks.
//  * `nr_free` is the total number of the free memory blocks.
//  */
// static void
// default_init(void) {
//     list_init(&free_list);
//     nr_free = 0;
// }
//
// // 需要注意，default_init_memmap default_alloc_pages default_free_pages 三个函数只是给大家提供一点思路
// // 需要去重写函数
// // 这里需要大家去理解通用链表结构 即list_entry_t与Page结构的关系
// // 注意在分配和回收Page时候，注意设置FLAGS property等数据结构
// /*
//  * (3) `default_init_memmap`:
//  *  CALL GRAPH: `kern_init` --> `pmm_init` --> `page_init` --> `init_memmap` -->
//  * `pmm_manager` --> `init_memmap`.
//  *  This function is used to initialize a free block (with parameter `addr_base`,
//  * `page_number`). In order to initialize a free block, firstly, you should
//  * initialize each page (defined in memlayout.h) in this free block. This
//  * procedure includes:
//  *  - Setting the bit `PG_property` of `p->flags`, which means this page is
//  * valid. P.S. In function `pmm_init` (in pmm.c), the bit `PG_reserved` of
//  * `p->flags` is already set.
//  *  - If this page is free and is not the first page of a free block,
//  * `p->property` should be set to 0.
//  *  - If this page is free and is the first page of a free block, `p->property`
//  * should be set to be the total number of pages in the block.
//  *  - `p->ref` should be 0, because now `p` is free and has no reference.
//  *  After that, We can use `p->page_link` to link this page into `free_list`.
//  * (e.g.: `list_add_before(&free_list, &(p->page_link));` )
//  *  Finally, we should update the sum of the free memory blocks: `nr_free += n`.
//  */
// static void
// default_init_memmap(struct Page *base, size_t n) {
//     assert(n > 0);
//     struct Page *p = base;
//
//     // 遍历所有空闲page：
//     // 1. 将描述空闲块数目的property置零(故该成员变量只有在整个空闲块的第一个page中才有意义),
//     // 2. 清空这些物理页的引用计数ref,
//     // 3. 设置flags = PG_property = 1将物理页标记为空闲可分配状态
//     for (; p != base + n; p ++) {
//         assert(PageReserved(p));
//         // flags: 物理页的状态：空闲与否
//         // property: 描述空闲块的数目, used in first fit pm manager
//         p->flags = p->property = 0;
//         set_page_ref(p, 0);
//         // SetPageProperty在memelayout.h中定义为: set_bit(PG_property, &((page)->flags))
//         // 即令flags = PG_property = 1，表示该页可分配
//         SetPageProperty(p);
//     }
//
//     // 对空闲块的第一个page进行初始化（完成初始化空闲页信息的工作）：
//     // 1. 设置块内共有空闲page = n
//     // 2. 更新所有空闲page数量的全局变量nr_free = n
//     // 3. 将该空闲块插入到空闲内存块链表中(使用块内第一个page的首部地址作为块地址)
//     base->property = n;
//
//     nr_free += n;   // 设置当前空闲page总数为n
//     list_add(&free_list, &(base->page_link));
// }
//
// /*
// (4) `default_alloc_pages`:
//  *  Search for the first free block (block size >= n) in the free list and reszie
//  * the block found, returning the address of this block as the address required by
//  * `malloc`.
// */
// // 以下为first-fit算法实现的空闲页分配
// static struct Page *
// default_alloc_pages(size_t n) {
//     assert(n > 0);
//     // 无空闲页可分配
//     if (n > nr_free) {
//         return NULL;
//     }
//
//     struct Page *page = NULL;
//     // (4.1) So you should search the free list like this :
//     list_entry_t *le = &free_list;
//
//     //  (4.1.1) In the while loop, get the struct `page` and
//     // check if `p->property`(recording the num of free pages in this block) >= n.
//     while ((le = list_next(le)) != &free_list)
//     {
//         // convert list entry to page
//         // 定义在memelayout.h中：le2page(le, member)    to_struct((le), struct Page, member)
//         struct Page *p = le2page(le, page_link);
//         // 碰到第一个页数满足条件的块就停止（首次适应思想）
//         if (p->property >= n) {
//             page = p;
//             break;
//         }
//     }
//
//     // (4.1.2) 若找到了满足条件的空闲块
//     if (page != NULL) {
//         // 通过变量page（显示所选中的块中第一块能分的page）定位到要分配的页
//         // 分配n页后终止
//         // 分配时将page的flags置为0（即已分配状态）
//         for (struct Page *tp = page; tp != page + n; tp++) {
//             // 定义在memelayout.h中：ClearPageProperty(page) clear_bit(PG_property, &((page)->flags))
//             ClearPageProperty(tp);
//         }
//
//         // 在freelist中删除该分配出去的块
//         list_del(&(page->page_link));
//
//         // 在原位插入一个减去分配出去的页数的空闲块，替代原空闲块
//         if (page->property > n) {
//             struct Page *p = page + n;
//             p->property = page->property - n;
//             list_add(&free_list, &(p->page_link));
//         }
//         // (4.1.3) Re - caluclate `nr_free` (number of the the rest of all free block).
//         nr_free -= n;
//     }
//
//     // (4.1.4) return `p`.
//     // (4.2) If we can not find a free block with its size >=n, then return NULL.
//     return page;
// }
//
// static void
// default_free_pages(struct Page *base, size_t n) {
//     assert(n > 0);
//     struct Page *p = base;
//     for (; p != base + n; p ++) {
//         assert(!PageReserved(p) && !PageProperty(p));
//         p->flags = 0;
//         set_page_ref(p, 0);
//     }
//     base->property = n;
//     SetPageProperty(base);
//     list_entry_t *le = list_next(&free_list);
//     while (le != &free_list) {
//         p = le2page(le, page_link);
//         le = list_next(le);
//         if (base + base->property == p) {
//             base->property += p->property;
//             ClearPageProperty(p);
//             list_del(&(p->page_link));
//         }
//         else if (p + p->property == base) {
//             p->property += base->property;
//             ClearPageProperty(base);
//             base = p;
//             list_del(&(p->page_link));
//         }
//     }
//     nr_free += n;
//     list_add(&free_list, &(base->page_link));
// }
//
// static size_t
// default_nr_free_pages(void) {
//     return nr_free;
// }
//
// static void
// basic_check(void) {
//     struct Page *p0, *p1, *p2;
//     p0 = p1 = p2 = NULL;
//     assert((p0 = alloc_page()) != NULL);
//     assert((p1 = alloc_page()) != NULL);
//     assert((p2 = alloc_page()) != NULL);
//
//     assert(p0 != p1 && p0 != p2 && p1 != p2);
//     assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
//
//     assert(page2pa(p0) < npage * PGSIZE);
//     assert(page2pa(p1) < npage * PGSIZE);
//     assert(page2pa(p2) < npage * PGSIZE);
//
//     list_entry_t free_list_store = free_list;
//     list_init(&free_list);
//     assert(list_empty(&free_list));
//
//     unsigned int nr_free_store = nr_free;
//     nr_free = 0;
//
//     assert(alloc_page() == NULL);
//
//     free_page(p0);
//     free_page(p1);
//     free_page(p2);
//     assert(nr_free == 3);
//
//     assert((p0 = alloc_page()) != NULL);
//     assert((p1 = alloc_page()) != NULL);
//     assert((p2 = alloc_page()) != NULL);
//
//     assert(alloc_page() == NULL);
//
//     free_page(p0);
//     assert(!list_empty(&free_list));
//
//     struct Page *p;
//     assert((p = alloc_page()) == p0);
//     assert(alloc_page() == NULL);
//
//     assert(nr_free == 0);
//     free_list = free_list_store;
//     nr_free = nr_free_store;
//
//     free_page(p);
//     free_page(p1);
//     free_page(p2);
// }
//
// // LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// // NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
// static void
// default_check(void) {
//     int count = 0, total = 0;
//     list_entry_t *le = &free_list;
//     while ((le = list_next(le)) != &free_list) {
//         struct Page *p = le2page(le, page_link);
//         assert(PageProperty(p));
//         count ++, total += p->property;
//     }
//     assert(total == nr_free_pages());
//
//     basic_check();
//
//     struct Page *p0 = alloc_pages(5), *p1, *p2;
//     assert(p0 != NULL);
//     assert(!PageProperty(p0));
//
//     list_entry_t free_list_store = free_list;
//     list_init(&free_list);
//     assert(list_empty(&free_list));
//     assert(alloc_page() == NULL);
//
//     unsigned int nr_free_store = nr_free;
//     nr_free = 0;
//
//     free_pages(p0 + 2, 3);
//     assert(alloc_pages(4) == NULL);
//     assert(PageProperty(p0 + 2) && p0[2].property == 3);
//     assert((p1 = alloc_pages(3)) != NULL);
//     assert(alloc_page() == NULL);
//     assert(p0 + 2 == p1);
//
//     p2 = p0 + 1;
//     free_page(p0);
//     free_pages(p1, 3);
//     assert(PageProperty(p0) && p0->property == 1);
//     assert(PageProperty(p1) && p1->property == 3);
//
//     assert((p0 = alloc_page()) == p2 - 1);
//     free_page(p0);
//     assert((p0 = alloc_pages(2)) == p2 + 1);
//
//     free_pages(p0, 2);
//     free_page(p2);
//
//     assert((p0 = alloc_pages(5)) != NULL);
//     assert(alloc_page() == NULL);
//
//     assert(nr_free == 0);
//     nr_free = nr_free_store;
//
//     free_list = free_list_store;
//     free_pages(p0, 5);
//
//     le = &free_list;
//     while ((le = list_next(le)) != &free_list) {
//         struct Page *p = le2page(le, page_link);
//         count --, total -= p->property;
//     }
//     assert(count == 0);
//     assert(total == 0);
// }
//
// const struct pmm_manager default_pmm_manager = {
//     .name = "default_pmm_manager",
//     .init = default_init,
//     .init_memmap = default_init_memmap,
//     .alloc_pages = default_alloc_pages,
//     .free_pages = default_free_pages,
//     .nr_free_pages = default_nr_free_pages,
//     .check = default_check,
// };












#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>

/*  In the First Fit algorithm, the allocator keeps a list of free blocks
 * (known as the free list). Once receiving a allocation request for memory,
 * it scans along the list for the first block that is large enough to satisfy
 * the request. If the chosen block is significantly larger than requested, it
 * is usually splitted, and the remainder will be added into the list as
 * another free block.
 *  Please refer to Page 196~198, Section 8.2 of Yan Wei Min's Chinese book
 * "Data Structure -- C programming language".
*/
// LAB2 EXERCISE 1: YOUR CODE
// you should rewrite functions: `default_init`, `default_init_memmap`,
// `default_alloc_pages`, `default_free_pages`.
/*
 * Details of FFMA
 * (1) Preparation:
 *  In order to implement the First-Fit Memory Allocation (FFMA), we should
 * manage the free memory blocks using a list. The struct `free_area_t` is used
 * for the management of free memory blocks.
 *  First, you should get familiar with the struct `list` in list.h. Struct
 * `list` is a simple doubly linked list implementation. You should know how to
 * USE `list_init`, `list_add`(`list_add_after`), `list_add_before`, `list_del`,
 * `list_next`, `list_prev`.
 *  There's a tricky method that is to transform a general `list` struct to a
 * special struct (such as struct `page`), using the following MACROs: `le2page`
 * (in memlayout.h), (and in future labs: `le2vma` (in vmm.h), `le2proc` (in
 * proc.h), etc).
 * (2) `default_init`:
 *  You can reuse the demo `default_init` function to initialize the `free_list`
 * and set `nr_free` to 0. `free_list` is used to record the free memory blocks.
 * `nr_free` is the total number of the free memory blocks.
 * (3) `default_init_memmap`:
 *  CALL GRAPH: `kern_init` --> `pmm_init` --> `page_init` --> `init_memmap` -->
 * `pmm_manager` --> `init_memmap`.
 *  This function is used to initialize a free block (with parameter `addr_base`,
 * `page_number`). In order to initialize a free block, firstly, you should
 * initialize each page (defined in memlayout.h) in this free block. This
 * procedure includes:
 *  - Setting the bit `PG_property` of `p->flags`, which means this page is
 * valid. P.S. In function `pmm_init` (in pmm.c), the bit `PG_reserved` of
 * `p->flags` is already set.
 *  - If this page is free and is not the first page of a free block,
 * `p->property` should be set to 0.
 *  - If this page is free and is the first page of a free block, `p->property`
 * should be set to be the total number of pages in the block.
 *  - `p->ref` should be 0, because now `p` is free and has no reference.
 *  After that, We can use `p->page_link` to link this page into `free_list`.
 * (e.g.: `list_add_before(&free_list, &(p->page_link));` )
 *  Finally, we should update the sum of the free memory blocks: `nr_free += n`.
 * (4) `default_alloc_pages`:
 *  Search for the first free block (block size >= n) in the free list and reszie
 * the block found, returning the address of this block as the address required by
 * `malloc`.
 *  (4.1)
 *      So you should search the free list like this:
 *          list_entry_t le = &free_list;
 *          while((le=list_next(le)) != &free_list) {
 *          ...
 *      (4.1.1)
 *          In the while loop, get the struct `page` and check if `p->property`
 *      (recording the num of free pages in this block) >= n.
 *              struct Page *p = le2page(le, page_link);
 *              if(p->property >= n){ ...
 *      (4.1.2)
 *          If we find this `p`, it means we've found a free block with its size
 *      >= n, whose first `n` pages can be malloced. Some flag bits of this page
 *      should be set as the following: `PG_reserved = 1`, `PG_property = 0`.
 *      Then, unlink the pages from `free_list`.
 *          (4.1.2.1)
 *              If `p->property > n`, we should re-calculate number of the rest
 *          pages of this free block. (e.g.: `le2page(le,page_link))->property
 *          = p->property - n;`)
 *          (4.1.3)
 *              Re-caluclate `nr_free` (number of the the rest of all free block).
 *          (4.1.4)
 *              return `p`.
 *      (4.2)
 *          If we can not find a free block with its size >=n, then return NULL.
 * (5) `default_free_pages`:
 *  re-link the pages into the free list, and may merge small free blocks into
 * the big ones.
 *  (5.1)
 *      According to the base address of the withdrawed blocks, search the free
 *  list for its correct position (with address from low to high), and insert
 *  the pages. (May use `list_next`, `le2page`, `list_add_before`)
 *  (5.2)
 *      Reset the fields of the pages, such as `p->ref` and `p->flags` (PageProperty)
 *  (5.3)
 *      Try to merge blocks at lower or higher addresses. Notice: This should
 *  change some pages' `p->property` correctly.
 */

static void print_free_area_info();
static void my_default_check();


free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
}

static void
default_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;

    // 遍历所有空闲page：
    // 1. 将描述空闲块数目的property置零(故该成员变量只有在整个空闲块的第一个page中才有意义),
    // 2. 清空这些物理页的引用计数ref,
    // 3. 设置flags = PG_property = 1将物理页标记为空闲可分配状态
    for (; p != base + n; p ++) {
        assert(PageReserved(p));
        // flags: 物理页的状态：空闲与否
        // property: 描述空闲块的数目, used in first fit pm manager
        p->flags = p->property = 0; 
        set_page_ref(p, 0);        
    }

    // 对空闲块的第一个page进行初始化（完成初始化空闲页信息的工作）：
    // 1. 设置块内共有空闲page = n
    // 2. 更新所有空闲page数量的全局变量nr_free = n
    // 3. 将该空闲块插入到空闲内存块链表中(使用块内第一个page的首部地址作为块地址)
    // SetPageProperty在memelayout.h中定义为: set_bit(PG_property, &((page)->flags))
    // 即令flags = PG_property = 1，表示该页可分配
    SetPageProperty(base);
    list_add_before(&free_list, &(base->page_link)); // 地址由低向高增长
    base->property = n;
    
    nr_free += n;   // 设置当前空闲page总数为n
    cprintf("[default_init_memmap]\n");
}

/*
(4) `default_alloc_pages`: 
 *  Search for the first free block (block size >= n) in the free list and reszie
 * the block found, returning the address of this block as the address required by
 * `malloc`.
*/
// 以下为first-fit算法实现的空闲页分配
static struct Page *
default_alloc_pages(size_t n) {
    assert(n > 0);
    // 无空闲页可分配
    if (n > nr_free) {
        return NULL;
    }

    struct Page *page = NULL;
    // (4.1) So you should search the free list like this : 
    list_entry_t *le = &free_list;

    //  (4.1.1) In the while loop, get the struct `page` and
    // check if `p->property`(recording the num of free pages in this block) >= n.
    while ((le = list_next(le)) != &free_list)
    {
        // convert list entry to page
        // 定义在memelayout.h中：le2page(le, member)    to_struct((le), struct Page, member)
        struct Page *p = le2page(le, page_link);
        // 碰到第一个页数满足条件的块就停止（首次适应思想）
        if (p->property >= n) {
            page = p;
            break;
        }
    }
    
    // (4.1.2) 若找到了满足条件的空闲块
    if (page != NULL) {       

        // 分割块：在原位插入一个减去分配出去的页数的空闲块，替代原空闲块
        if (page->property > n) {
            struct Page *p = page + n;
            // 将page的空闲块数目位property置0
            SetPageProperty(p);
            p->property = page->property - n;
            list_add(&(page->page_link), &(p->page_link));
        }
        // 在freelist中删除该分配出去的块
        list_del(&(page->page_link));
        // (4.1.3) Re - caluclate `nr_free` (number of the the rest of all free block).
        nr_free -= n;
        // 通过变量page（显示所选中的块中第一块能分的page）定位到要分配的页
        // 分配n页后终止
        // 分配时将page的flags置为0（即已分配状态）

        // 定义在memelayout.h中：ClearPageProperty(page) clear_bit(PG_property, &((page)->flags))
        ClearPageProperty(page);
        // for (struct Page *tp = page; tp != page + n; tp++)
        // {
        //     SetPageReserved(tp);
        //     // 定义在memelayout.h中：ClearPageProperty(page) clear_bit(PG_property, &((page)->flags))
        //     ClearPageProperty(tp);
        //     // // 在freelist中删除该分配出去的块
        //     // list_del(&(page->page_link));
        // }
    }
    cprintf("[default_alloc_pages]\n");
    // (4.1.4) return `p`.
    // (4.2) If we can not find a free block with its size >=n, then return NULL.
    return page;
}


static void
default_free_pages(struct Page *base, size_t n) {
    // (5.1) According to the base address of the withdrawed blocks, 
    // search the freelist for its correct position (with address from low to high), 
    // and insert the pages. (May use `list_next`, `le2page`, `list_add_before`)

    assert(n > 0);

    struct Page *p = base;
    
    // 检查页flags是否正确，将reserve（保留）和ref（引用）位 置为0
    for (; p != base + n; p ++) {
        // 确定这些页是已经被保留/占用了的
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);

    list_entry_t *le = list_next(&free_list);
    list_entry_t *nxt = &free_list;
    while (le != &free_list) {
        // 向高地址合并
        p = le2page(le, page_link);
        le = list_next(le);
        if (base + base->property == p) {
            base->property += p->property;
            // 无空闲块了
            p->property = 0;
            // 设置为非空闲，flags=1
            ClearPageProperty(p);
            nxt = (p->page_link).next;
            list_del(&(p->page_link));
        }
        // 向低地址合并
        else if (p + p->property == base) {
            p->property += base->property;
            base->property = 0;
            ClearPageProperty(base);
            base = p;
            nxt = (p->page_link).next;
            list_del(&(p->page_link));
        }
        else if (base + base->property < p && nxt == NULL)
        {
            nxt = le;
            break;
        }
    }
    nr_free += n;
    list_add_before(nxt, &(base->page_link));
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}

static void
basic_check(void) {
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    assert(alloc_page() == NULL);

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(alloc_page() == NULL);

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count ++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
    assert((p1 = alloc_pages(3)) != NULL);
    assert(alloc_page() == NULL);
    assert(p0 + 2 == p1);

    p2 = p0 + 1;
    free_page(p0);
    free_pages(p1, 3);
    assert(PageProperty(p0) && p0->property == 1);
    assert(PageProperty(p1) && p1->property == 3);

    assert((p0 = alloc_page()) == p2 - 1);
    free_page(p0);
    assert((p0 = alloc_pages(2)) == p2 + 1);

    free_pages(p0, 2);
    free_page(p2);

    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);

    //my_default_check();
}


static void
my_default_check() {
    struct Page *p0 = alloc_pages(100);
    cprintf("alloc 100 pages\n");
    print_free_area_info();

    free_pages(p0, 10);
    print_free_area_info();
    free_pages(p0 + 20, 10);
    print_free_area_info();
    free_pages(p0 + 40, 10);
    print_free_area_info();
    free_pages(p0 + 60, 10);
    print_free_area_info();
    free_pages(p0 + 80, 10);
    print_free_area_info();


    free_pages(p0 + 90, 10);
    print_free_area_info();
    free_pages(p0 + 70, 10);
    print_free_area_info();
    free_pages(p0 + 50, 10);
    print_free_area_info();
    free_pages(p0 + 30, 10);
    print_free_area_info();
    free_pages(p0 + 10, 10);
    print_free_area_info();

    cprintf("after free\n");
    print_free_area_info();
}


static void
print_free_area_info() {
    cprintf("-----free area info begin-----\n");
    cprintf("nr_free: %d\n", nr_free);
    cprintf("%10s%10s%10s%5s%15s%15s\n", "begin_ppn","end_ppn", "page_cnt", "ref", "PG_reserved", "PG_property");
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
        struct Page *p = le2page(le, page_link);
        cprintf("%10d%10d%10d%5d%15d%15d\n",
            page2ppn(p), page2ppn(p) + p->property - 1, p->property,
            p->ref, PageReserved(p), PageProperty(p));
    }
    cprintf("-----free area info end-------\n");
}

const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,
    .init_memmap = default_init_memmap,
    .alloc_pages = default_alloc_pages,
    .free_pages = default_free_pages,
    .nr_free_pages = default_nr_free_pages,
    .check = default_check,
};
