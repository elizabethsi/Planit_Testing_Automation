*** Variables ***
#Contact Page Elements
${page_Logo} =  //h1[contains(text(),'Jupiter Toys')]
${contact_Link} =   //a[contains(@href, '#/contact')]
${contact_Head} =   //div[@class='alert alert-info ng-scope']
${contact_Frm} =    //form[@name='form']
${submit_Btn} =  //a[contains(text(),'Submit')]
${alert_Err} =  //div[@class='alert alert-error ng-scope']
${forename_Err} =   //span[@id='forename-err']
${email_Err} =  //span[@id='email-err']
${message_Err} =    //span[@id='message-err']
${forename_Txt} =   //input[@id='forename']
${email_Txt} =   //input[@id='email']
${message_Txt} =   //textarea[@id='message']
${feedback_Mod} =   //h1[contains(text(), 'Sending Feedback')]
${sucess_Msg} =     //div[@class='alert alert-success']

#Shop Page Elements
${shop_Link} =   //a[contains(@href, '#/shop')]
${cart_Link} =  //a[contains(@href, '#/cart')]
${product_List} =   //div[@class='products ng-scope']
#Product List
${prod_1} =     Teddy Bear
${prod_2} =     Stuffed Frog
${prod_3} =     Handmade Doll
${prod_4} =     Fluffy Bunny
${prod_5} =     Smiley Bear
${prod_6} =     Funny Cow
${prod_7} =     Valentine Bear
${prod_8} =     Smiley Face

${item_1st} =   //h4[contains(text(),'${prod_6}')]/../..//a[contains(text(),'Buy')]
${item_2nd} =   //h4[contains(text(),'${prod_4}')]/../..//a[contains(text(),'Buy')]
${item_3rd} =   //h4[contains(text(),'${prod_2}')]/../..//a[contains(text(),'Buy')]
${item_4th} =   //h4[contains(text(),'${prod_7}')]/../..//a[contains(text(),'Buy')]

${cart_1st} =   //td[contains(text(),'${prod_6}')]
${cart_2nd} =   //td[contains(text(),'${prod_4}')]
${cart_Msg} =   //p[@class='cart-msg']




