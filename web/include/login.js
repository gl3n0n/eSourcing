﻿// Created By: GA Sacramento 
// Last Update: 07262006
// **********************************************************************************************************
// Focus
function Focus()
{
	var usr = document.getElementById("_ctl0_ContentPlaceHolder1_txtUserName");
	var usr2 = document.getElementById("_ctl0_ContentPlaceHolder1_txtUserName2");
	var pwd = document.getElementById("_ctl0_ContentPlaceHolder1_txtPassword");
	var pwd2 = document.getElementById("_ctl0_ContentPlaceHolder1_txtCurrentPwd");
			
	if ((usr != null) && (pwd != null))
	{
		if ((usr.value == "")  || (usr.value == null))
			usr.focus();
		else 
			pwd.focus();
	}
	else if (usr2 != null)
	{
		usr2.focus();
	}
	else if (pwd2 != null)
	{
	    pwd2.focus();
	}
}
function Focus2()
{
	var usr = document.getElementById("_ctl0_ContentPlaceHolder1_txtUserName");		
	if (usr != null)
	{
		usr.focus();			
	}		
}
// **********************************************************************************************************