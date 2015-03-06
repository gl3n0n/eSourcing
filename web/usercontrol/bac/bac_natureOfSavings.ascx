﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="bac_natureOfSavings.ascx.cs" Inherits="web_usercontrol_bac_natureOfSavings" %>
<table width="100%" border="1" cellpadding="0" cellspacing="0" rules="all"
																class="itemDetails" id="BidTendersAccumulatedCost"
																style="border-color:#71A9D2; font-family: Arial; font-size: 11px; border-collapse: collapse; background-color: rgb(219, 234, 245); height:100%">
																<tbody>
																	<tr>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">NATURE OF SAVINGS</td>
																		<td class="ui-widget-header" style="height:26px; vertical-align:middle;">SAVINGS GENERATED</td>
																	</tr>
																	<tr valign="middle" >
																		<td width="50%" align="center">
																			<asp:DataList runat="server"  DataSourceID="dsBACNatureOfSavings" 
                                                                                ID="DataList16" Font-Bold="True" Font-Size="12px" >
                                                                                  <ItemTemplate>
                                                                                  <asp:label runat="server" ID="nature_of_savings" Name="nature_of_savings" Text='<%# Eval("NatureOfSavings") %>' >

                                                                                  
                                                                                  </asp:label>
                                                                                  </ItemTemplate>
                                                                             </asp:DataList>
                                                                             <asp:SqlDataSource ID="dsBACNatureOfSavings" runat="server" 
                                                                            ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                                            SelectCommand="SELECT NatureOfSavings FROM tblBACNatureOfSavings WHERE BidRefNo=@BidRefNo" >
																					<SelectParameters>
																						<asp:SessionParameter Name="BidRefNo" SessionField="BuyerBidForBac" Type="Int32" />
																					</SelectParameters>
																			</asp:SqlDataSource>
																		</td>
																		<td align="center" valign="middle" style="padding:5px; font-size:12px;" class="style4">
																			<table style="width: 80%;">
                                                                                <tr>
																					<td class="style5">Parent Accumulated Award Cost:</td>
																					<td align="right">
                                                                                    <asp:DataList runat="server"  DataSourceID="dsBuyerBidForBacParent" ID="DataList1" 
                                                                                            Font-Bold="True" Font-Size="12px" >
                                                                                  <ItemTemplate>
                                                                                  <asp:label runat="server" ID="lblAccCostParent" Name="lblAccCostParent" Text='<%# String.Format("{0:#,##0.00}", Convert.ToDouble(Eval("AccumulativeCostParent"))) %>'  Font-Size="12px">
                                                                                  </asp:label>
                                                                                  </ItemTemplate>
                                                                             </asp:DataList>
															<asp:SqlDataSource ID="dsBuyerBidForBacParent" runat="server" ConnectionString="<%$ ConnectionStrings:EBidConnectionString %>"
                                                            SelectCommand="SELECT t2.AccumulativeCost AS AccumulativeCostParent FROM tblBACBidItems t1, tblBACBidItems t2 WHERE t1.BacRefNo=@BacRefNo AND t2.BidRefNo = CASE WHEN t1.BidRefNoParent IS NULL THEN 0 ELSE t1.BidRefNoParent END"  >
																	<SelectParameters>
																		<asp:SessionParameter Name="BacRefNo" SessionField="BuyerBacRefNo" Type="Int32" />
																	</SelectParameters>
															</asp:SqlDataSource>
                                                                                    </td>
																				</tr>
																				<tr>
																					<td class="style5">Accumulated Award Cost:</td>
																					<td align="right">
                                                                                    <asp:DataList runat="server"  DataSourceID="dsBuyerBidForBac" ID="DataList17" 
                                                                                            Font-Bold="True" Font-Size="12px" >
                                                                                  <ItemTemplate>
                                                                                  <asp:label runat="server" ID="lblAccCost" Name="lblAccCost" Text='<%# String.Format("{0:#,##0.00}", Convert.ToDouble(Eval("AccumulativeCost"))) %>'  Font-Size="12px">
                                                                                  </asp:label>
                                                                                  </ItemTemplate>
                                                                             </asp:DataList>
                                                                                    </td>
																				</tr>
																				<tr>
																					<td class="style5">Savings Amount:</td>
																					<td align="right">
                                                                                    <asp:DataList runat="server"  DataSourceID="dsBuyerBidForBac" ID="DataList18" 
                                                                                            Font-Bold="True" Font-Size="12px" >
                                                                                  <ItemTemplate>
                                                                                  <asp:label runat="server" ID="lblNegDisc" Name="lblNegDisc" Text='<%# String.Format("{0:#,##0.00}", Convert.ToDouble(Eval("SavingsGen_Amount"))) %>'  Font-Size="12px">
                                                                                  </asp:label>
                                                                                  </ItemTemplate>
                                                                             </asp:DataList>
                                                                                    </td>
																				</tr>
																				<tr>
																					<td class="style5">% Savings:</td>
																					<td align="right">
                                                                                    <asp:DataList runat="server"  DataSourceID="dsBuyerBidForBac" ID="DataList19" 
                                                                                            Font-Bold="True" Font-Size="12px" >
                                                                                  <ItemTemplate>
                                                                                  <asp:label runat="server" ID="lblPercentSpend" Name="lblPercentSpend" Text='<%# Eval("SavingsGen_PctSpend")+"%" %>'  Font-Size="12px">
                                                                                  </asp:label>
                                                                                  </ItemTemplate>
                                                                             </asp:DataList></td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</tbody>
															</table>