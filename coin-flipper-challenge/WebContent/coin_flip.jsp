<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<html>
<head>
<title>Coin Flipper Challenge</title>
</head>
<body style="overflow:hidden;">
<H1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Call As Many Flips As You Can!</H1>
	<%
HttpSession currentSession = request.getSession();
int numberOfGameFlipHeads = 0;
int numberOfGameFlipTails = 0;
int numberOfMatches = 0;
int currentPlayerHighestScore = 0;
if (currentSession.isNew()) currentSession.setAttribute("numberOfGameFlipHeads", new Integer(0));
if (currentSession.isNew()) currentSession.setAttribute("numberOfGameFlipTails", new Integer(0));
if (currentSession.isNew()) currentSession.setAttribute("numberOfMatches", new Integer(0));
if (currentSession.isNew()) currentSession.setAttribute("isGameActive", new Boolean(true));
if (currentSession.isNew()) currentSession.setAttribute("history", new ArrayList<String>());
if (currentSession.isNew()) currentSession.setAttribute("currentPlayerHighestScore", new Integer(0));

String gameFlip="";
if (Math.random() < 0.5) 
	gameFlip="HEADS"; 
else
	gameFlip="TAILS";
%>

	<FORM ACTION="coin_flip.jsp">
		<INPUT TYPE="radio" NAME="flips" VALUE="radio_heads" CHECKED>
		<img src="images/coin_heads.png" /> 
	
		<INPUT TYPE="radio"	NAME="flips" VALUE="radio_tails"> 
		<img src="images/coin_tails.png" />
		
		<INPUT TYPE="radio"	NAME="flips" VALUE="radio_reset"> 
		<img src="images/reset_button.png" />
		<BR/>
		<INPUT TYPE="submit" VALUE="Proceed!" align="center" style="width:711px; height:50px;font-size:40px;">
	</FORM>
	<%
Date date = Calendar.getInstance().getTime();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-hh:mm:ss");
String playerFlip = null;

if (request.getParameter("flips") != null){
	if(request.getParameter("flips").equals("radio_heads")) {
		if (((Boolean)currentSession.getAttribute("isGameActive")).booleanValue() == false){
			currentSession.setAttribute("buttonMessage", "Flip the Coin!");
			response.sendRedirect(request.getContextPath() + "/coin_flip.jsp?flips=radio_reset");
		} else {
		playerFlip="HEADS";
		}
	}
	if(request.getParameter("flips").equals("radio_tails")) {
		if (((Boolean)currentSession.getAttribute("isGameActive")).booleanValue() == false){
			currentSession.setAttribute("buttonMessage", "Flip the Coin!");
			response.sendRedirect(request.getContextPath() + "/coin_flip.jsp?flips=radio_reset");
		} else {
		playerFlip="TAILS";
		}
	}
	if(request.getParameter("flips").equals("radio_reset")) {
		currentSession.setAttribute("numberOfGameFlipHeads", new Integer(0));
		currentSession.setAttribute("numberOfGameFlipTails", new Integer(0));
		currentSession.setAttribute("numberOfMatches", new Integer(0));
		currentSession.setAttribute("isGameActive", new Boolean(true));
		currentSession.setAttribute("history", new ArrayList<String>());
		response.sendRedirect(request.getContextPath() + "/coin_flip.jsp");
	}
}
if (playerFlip != null && playerFlip.length()!= 0 ) {
	if (gameFlip.equals("HEADS")){
		numberOfGameFlipHeads = ((Integer)currentSession.getAttribute("numberOfGameFlipHeads")).intValue();
		numberOfGameFlipHeads++;
		currentSession.setAttribute("numberOfGameFlipHeads", numberOfGameFlipHeads);
		((ArrayList<String>)currentSession.getAttribute("history")).add(sdf.format(date) + "!" + "HEADS");
	}
	if (gameFlip.equals("TAILS")){
		numberOfGameFlipTails =  ((Integer)currentSession.getAttribute("numberOfGameFlipTails")).intValue();
		numberOfGameFlipTails++;
		currentSession.setAttribute("numberOfGameFlipTails", numberOfGameFlipTails);
		((ArrayList<String>)currentSession.getAttribute("history")).add(sdf.format(date) + "!" + "TAILS");
	}
}
%>
<style type="text/css">
	.inlineTable {
	display: inline-block;
	}
</style>
	<%
		if (!currentSession.isNew() && playerFlip != null && ((Boolean)currentSession.getAttribute("isGameActive")).booleanValue() == true ) {
	%>
	<BR/>
	<TABLE BORDER="1" class="inlineTable">
		<TR>
			<TH>Your Last Call</TH>
			<TH>Game Last Flip</TH>
			<TH>Result</TH>
			<TH>What's Next?</TH>
		</TR>
		<TR>
			<%
			if (playerFlip.equals("HEADS")){
			%>
			<TD><img src="images/coin_heads-table.png" /></TD>
			<%
			}
			%>
			<%
			if (playerFlip.equals("TAILS")){
			%>
			<TD><img src="images/coin_tails-table.png" /></TD>
			<%
			}
			%>
			<%
			if (gameFlip.equals("HEADS")){
			%>
			<TD><img src="images/coin_heads-table.png" /></TD>
			<%
			}
			%>
			<%
			if (gameFlip.equals("TAILS")){
			%>
			<TD><img src="images/coin_tails-table.png" /></TD>
			<%
			}
			%>
			<%
			if (playerFlip.equals(gameFlip)){
			%>
			<TD><img src="images/coin_flip_pass.png" /></TD>
			<%
				numberOfMatches = ((Integer)currentSession.getAttribute("numberOfMatches")).intValue();
				numberOfMatches++;
				currentSession.setAttribute("numberOfMatches", numberOfMatches);
				currentPlayerHighestScore = ((Integer)currentSession.getAttribute("currentPlayerHighestScore")).intValue();
				if (numberOfMatches > currentPlayerHighestScore){
					currentSession.setAttribute("currentPlayerHighestScore", new Integer(numberOfMatches));
				}
			%>
			<TD>Keep playing, you have <%= ((Integer)currentSession.getAttribute("numberOfMatches")).intValue() %> matches!</TD>
			<%	
			}
			%>
			<%
			if (!playerFlip.equals(gameFlip)){
			%>
			<TD><img src="images/coin_flip_fail.png" /></TD>
			<TD>Thanks for playing, you had <%= ((Integer)currentSession.getAttribute("numberOfMatches")).intValue() %> matches!</TD>
			<% 
				currentSession.setAttribute("isGameActive", new Boolean(false));
				currentPlayerHighestScore = ((Integer)currentSession.getAttribute("currentPlayerHighestScore")).intValue();
				numberOfMatches = ((Integer)currentSession.getAttribute("numberOfMatches")).intValue();
				if (numberOfMatches > currentPlayerHighestScore){
					currentSession.setAttribute("currentPlayerHighestScore", new Integer(numberOfMatches));
				}
			}
			%>
		</TR>
	</TABLE>
	<TABLE BORDER="1" class="inlineTable">
		<TR>
			<TH colspan="2">Game Tally</TH>
		</TR>
		<TR>
			<TD><img src="images/coin_heads-table.png" /></TD>
			<TD><img src="images/coin_tails-table.png" /></TD>
		</TR>
		<TR>
			<TD><%= ((Integer)currentSession.getAttribute("numberOfGameFlipHeads")).intValue() %></TD>
			<TD><%= ((Integer)currentSession.getAttribute("numberOfGameFlipTails")).intValue() %></TD>
		</TR>
	</TABLE>
	<TABLE BORDER="1" class="inlineTable">
		<TR>
			<TH>Current High Score</TH>
			<TH>All-Time High Score</TH>
		</TR>
		<TR>
			<TD><%= ((Integer)currentSession.getAttribute("currentPlayerHighestScore")).intValue() %></TD>
			<TD><%= ((Integer)currentSession.getAttribute("currentPlayerHighestScore")).intValue() %></TD>
		</TR>
	</TABLE>
	<style type="text/css">
		.table_history {
    		overflow-y:scroll;
    		overflow-x:hidden;
    		width:300px;
    		height:316px;
    	}
	</style>
	<div class="table_history">
	<TABLE BORDER="1">
		<TR>
			<TH colspan=2>Time</TH>
			<TH>Game Flip</TH>
		</TR>
		<%
	ArrayList<String> history = ((ArrayList<String>)currentSession.getAttribute("history"));
	String flipDate;
	String flipResult;
	String unfilteredFlipResult;
	for (int index=history.size()-1; index > -1; index--){
		unfilteredFlipResult = history.get(index);
		flipDate = unfilteredFlipResult.split("!")[0];
		flipResult = unfilteredFlipResult.split("!")[1];
		%>
		<TR>
			<TD colspan=2><%= flipDate %></TD>
			<%
			if (flipResult.equals("HEADS")){
			%>
			<TD colspan=1><img src="images/coin_heads-table.png" /></TD>
			<%
			}
			%>
			<%
			if (flipResult.equals("TAILS")){
			%>
			<TD colspan=1><img src="images/coin_tails-table.png" /></TD>
			<%
			}
			%>
		</TR>
		<% 	
	}
	%>
	</TABLE>
	</div>
	<%
}
%>

</body>
</html>
