@RestResource(urlMapping='/v1/BookManagement/*')
global class BookManager {
	@httpGet
    global static Book__c doGetBook(){
        
        Book__c book = new Book__c();
        Map<String,String> paramMap= RestContext.request.params;
        string bookId = paramMap.get('Id');
        book=[select id, name, Price__C from Book__c where id=:bookId];
        
        return book;
    }
    
    @httpDelete
    global static string doDeleteBook(){
        
        Book__c book = new Book__c();
        Map<String,String> paramMap= RestContext.request.params;
        string bookId = paramMap.get('Id');
        book=[select id, name, Price__C from Book__c where id=:bookId];
        delete book;
        return 'Record Deleted!';
    }
    @httpPost
    global static Book__c doCreateBook(String Name){
        
        Book__c book = new Book__c(Name=name);
        insert book;
        return book;
        
    }
    @httpPut
    global static Book__c doCrateBook(String Name){
        
        Map<String, String> paramsMap= RestContext.request.params;
        String bookId = paramsMap.get('id');
        Book__c book = new Book__c (Name=name, Id = bookId);
        update book;
        return book;
    }
}