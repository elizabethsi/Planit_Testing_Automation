*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     String
Library     Collections

Resource    ../PageObjects/JupiterLanding_Page.robot
Resource    ../Actions/Common.robot

*** Keywords ***
Contact Page Error Validation
    Open Browser and Navigate to Jupiter Toys
    click element   ${contact_Link}
    wait until page contains element    ${contact_Head}
    click element   ${submit_Btn}
    element should be visible   ${alert_Err}
    wait until element is visible   ${contact_Frm}
    ${contact_error_List} =     create list     ${forename_Err}     ${email_Err}    ${message_Err}
    FOR     ${list}     IN      ${contact_error_List}
        page should contain element      ${contact_error_List}   ${list}
    END
    input text  ${forename_Txt}     TestUser
    element should not be visible   ${forename_Err}
    input text  ${email_Txt}        TestUser
    page should contain element     ${email_Err}
    clear element text  ${email_Txt}
    input text  ${email_Txt}    TestUser.Valid@planit.net.au
    element should not be visible   ${email_Err}
    input text  ${message_Txt}      This is a test.
    element should not be visible   ${message_Err}

Contact Page Inputs Validation
    Open Browser and Navigate to Jupiter Toys
    click element   ${contact_Link}
    wait until page contains element    ${contact_Head}
    #Generate a random string to get different inputs for 5 tests
    ${forename} =   generate random string   8   [LOWER]
    input text  ${forename_Txt}     ${forename}
    ${email_add} =  catenate    SEPARATOR=  ${forename}    @planit.net.au
    input text  ${email_Txt}    ${email_add}
    input text  ${message_Txt}      This is a test.
    click element   ${submit_Btn}
    page should contain element     ${feedback_Mod}
    wait until page contains element   ${sucess_Msg}    timeout=15   error=false

Cart Items Validation
    Open Browser and Navigate to Jupiter Toys
    click element   ${shop_Link}
    wait until page contains element    ${product_List}
    FOR     ${index}    IN RANGE    2
        click element   ${item_1st}
    END
    click element   ${item_2nd}
    click element   ${cart_Link}
    wait until page contains element    ${cart_Msg}
    ${cart_items} =     create list     ${cart_1st}    ${cart_2nd}
    FOR     ${shop_list}     IN      ${cart_items}
        Log to console      ${cart_items}
        page should contain element      ${cart_items}      ${shop_list}
    END

Price Validation
    [Arguments]     ${item_1}   ${item_1_qty}   ${item_2}   ${item_2_qty}   ${item_3}   ${item_3_qty}
	#Initialize the Items, their Quantities
	#Also initialize an empty list and container for each Item's Total Cost and Overall Cost of 3 Items
	${cart_items} =		create list	${item_1}	${item_2}	${item_3}
	${item_quantity} =		create list	${item_1_qty}	${item_2_qty}	${item_3_qty}
	${item_total} =		create list
	${all_total} =		Set Variable	0
	${price_in_shop} =		create list
    Open Browser and Navigate to Jupiter Toys
    click element   ${shop_Link}
    wait until page contains element    ${product_List}

	#Getting and Computing the Prices

	#Run 3 Times since there are 3 Products
	FOR    ${index}    IN RANGE	3
		Log to console	${cart_items}[${index}]

		#Click the Buy Button multiple times based on Quantity
		FOR	${index_2}	IN RANGE	${item_quantity}[${index}]
			click element   xpath=//h4[contains(text(),'${cart_items}[${index}]')]/../..//a[contains(text(),'Buy')]
		END
		#Get the price of the current product being pointed at
		${prod_price} =   get text    xpath=//h4[contains(text(),'${cart_items}[${index}]')]/..//span
		Append To List		${price_in_shop}	${prod_price}

		#Convert the product and Quantity into a Number
		${subtotal} =   Remove String   ${prod_price}     $
		${subtotal_num} =		Convert To Number   ${subtotal}
		${item_quantity_num} =		Convert To Number	${item_quantity}[${index}]

		#Multiply the product's cost to Quantity
		${item_totalnum} =		Evaluate	${subtotal} * ${item_quantity_num}

		#Add Item's Total Cost to the list of Item Totals
		Append To List		${item_total}	${item_totalnum}
		Log to console	${item_totalnum}
	END
	Log to Console	${item_total}
	Log to Console	${price_in_shop}

	#Add the 3 Total Item Costs
	FOR    ${index}    IN RANGE	3
		${all_total} =		Evaluate	${item_total}[${index}] + ${all_total}
	END
	Log to Console	${all_total}
    click element   ${cart_Link}
    wait until page contains element    ${cart_Msg}

	#Checking the items in the cart
	FOR    ${index}    IN RANGE	3
		#Check if the Product Name is in the page
		page should contain element	xpath=//td[contains(text(),'${cart_items}[${index}]')]/..

		#Check if the Product's Price in Shop = Price in Cart
		${price_in_cart} =	get text	xpath=//td[contains(text(),'${cart_items}[${index}]')]/../td[2]
		Log to Console	${price_in_cart}	${price_in_shop}[${index}]
		Should Be Equal As Strings	${price_in_cart}	${price_in_shop}[${index}]

		#Check if the Product's Quantity in Shop = Quantity in Cart
		${quantity_in_cart} =	get value	//td[contains(text(),'${cart_items}[${index}]')]/..//input
		Log to Console	${quantity_in_cart}	${item_quantity}[${index}]
		Should Be Equal As Strings	${quantity_in_cart}	${item_quantity}[${index}]

		#Check if the Product's Total Price in Shop = Product Total Price in Cart
		${subtotal_in_cart} =	get text	xpath=//td[contains(text(),'${cart_items}[${index}]')]/../td[4]
		${subtotal_in_cart} =   Remove String   ${subtotal_in_cart}     $
		${subtotal_in_cart} =	Convert to Number	${subtotal_in_cart}
		Should Be Equal	${subtotal_in_cart}	${item_total}[${index}]
	END

	#Check if the Total Price in Shop = Total Price in Cart
	element should contain	xpath=//strong[@class="total ng-binding"]	${all_total}