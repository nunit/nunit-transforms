<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="yes" indent="yes" />
	<xsl:template match="/test-run">
		<html>
			<head>
        <title><xsl:value-of select="test-suite/@name"/> Test Results <xsl:value-of select="@start-time"/></title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
				<style type="text/css">
					body{
						margin: 20px !important;
					}
					.smllabel {
						width:150px;
						font-weight: bold;
					}
					td.left {
						text-align: left;
					}
					td.right {
						text-align: right;
					}
					.collapsed {
						border:0;
						border-collapse: collapse;
					}
					.results {
						font-weight: bold;
					}
					.total {
						padding-right: 5px;
					}
					.passed {
						color: green;
						margin-right: 5px;
					}
					.failed {
						color: red;
						margin-right: 5px;
					}
					.inconclusive {
						color: blue;
						margin-right: 5px;
					}
					.skipped {
						color: orange;
						margin-right: 5px;
					}
					.test-name {
					}
					h4{
						margin-top: 20px !important;
					}
				</style>
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous" />
			</head>
			<body>

				<!-- Command Line -->
				<h4>Command Line</h4>
				<pre>
					<xsl:value-of select="command-line"/>
				</pre>
				
				<h4>Test Run Summary</h4>
				<table id="summary" class="collapsed">
					<tr>
						<td class="smllabel right">Overall result:</td>
						<td class="left">
							<xsl:value-of select="@result"/>
						</td>
					</tr>
					<tr>
						<td class="smllabel right total">Test Count:</td>
						<td class="left results">							 
							<xsl:value-of select="@total"/>, <span class="passed">Passed:</span><xsl:value-of select="@passed"/>, <span class="failed">Failed:</span><xsl:value-of select="@failed"/>, <span class="inconclusive">Inconclusive:</span><xsl:value-of select="@inconclusive"/>, <span class="skipped">Skipped:</span><xsl:value-of select="@skipped"/>
						</td>
					</tr>

					<!-- [Optional] - Failed Test Summary -->
					<xsl:if test="@failed > 0">
						<xsl:variable name="failedTotal" select="count(//test-case[@result='Failed' and not(@label)])" />
						<xsl:variable name="errorsTotal" select="count(//test-case[@result='Failed' and @label='Error'])" />
						<xsl:variable name="invalidTotal" select="count(//test-case[@result='Failed' and @label='Invalid'])" />
						<tr>
							<td class="smllabel right">Failed Tests: </td>
							<td class="left">
								Failures: <xsl:value-of select="$failedTotal"/>, Errors: <xsl:value-of select="$errorsTotal"/>, Invalid: <xsl:value-of select="$invalidTotal"/>
							</td>
						</tr>
					</xsl:if>

					<!-- [Optional] - Skipped Test Summary -->
					<xsl:if test="@skipped > 0">
						<xsl:variable name="ignoredTotal" select="count(//test-case[@result='Skipped' and @label='Ignored'])" />
						<xsl:variable name="explicitTotal" select="count(//test-case[@result='Skipped' and @label='Explicit'])" />
						<xsl:variable name="otherTotal" select="count(//test-case[@result='Skipped' and not(@label='Explicit' or @label='Ignored')])" />
						<tr>
							<td class="smllabel right">Skipped Tests: </td>
							<td class="left">
								Ignored: <xsl:value-of select="$ignoredTotal"/>, Explicit: <xsl:value-of select="$explicitTotal"/>, Other: <xsl:value-of select="$otherTotal"/>
							</td>
						</tr>
					</xsl:if>

					<!-- Times -->
					<tr>
						<td class="smllabel right">Start time: </td>
						<td class="left">
							<xsl:value-of select="@start-time"/>
						</td>
					</tr>
					<tr>
						<td class="smllabel right">End time: </td>
						<td class="left">
							<xsl:value-of select="@end-time"/>
						</td>
					</tr>
					<tr>
						<td class="smllabel right">Duration: </td>
						<td class="left">
							<xsl:value-of select="format-number(@duration,'0.000')"/> seconds
						</td>
					</tr>	  
				</table>

				<!-- Runtime Environment -->
				<h4>Runtime Environment</h4>

				<table id="runtime">
					<tr>
						<td class="smllabel right">OS Version:</td>
						<td class="left">
							<xsl:value-of select="test-suite/environment/@os-version[1]"/>
						</td>
					</tr>
					<tr>
						<td class="smllabel right">CLR Version:</td>
						<td class="left">
							<xsl:value-of select="@clr-version"/>
						</td>
					</tr>
					<tr>
						<td class="smllabel right">NUnit Version:</td>
						<td class="left">
							<xsl:value-of select="@engine-version"/>
						</td>
					</tr>
				</table>

				<!-- Test Files -->
				<div id="testfiles">
					<h4>Test Files</h4>
					<xsl:if test="count(test-suite[@type='Assembly']) > 0">
						<ol>
							<xsl:for-each select="test-suite[@type='Assembly']">
								<li>
									<xsl:value-of select="@fullname"/>
								</li>
							</xsl:for-each>
						</ol>
					</xsl:if>
				</div>

				<!-- Tests Not Run -->
				<xsl:if test="//test-case[@result='Skipped']">
					<h4>Tests Not Run</h4>
					<ol>
						<xsl:apply-templates select="//test-case[@result='Skipped']"/>
					</ol>
				</xsl:if>

				<!-- Errors and Failures -->
				<xsl:if test="//test-case[failure]">
					<h4>Errors and Failures</h4>
					<ol>
						<xsl:apply-templates select="//test-case[failure]"/>
					</ol>
				</xsl:if>

				<!-- Run Settings (gets first one found) -->
				<xsl:variable name="settings" select ="//settings[1]" />

				<h4>Run Settings</h4>
				<ul>
					<li>
						DefaultTimeout: <xsl:value-of select="$settings/setting[@name='DefaultTimeout']/@value"/>
					</li>
					<li>
						WorkDirectory: <xsl:value-of select="$settings/setting[@name='WorkDirectory']/@value"/>
					</li>
					<li>
						ImageRuntimeVersion: <xsl:value-of select="$settings/setting[@name='ImageRuntimeVersion']/@value"/>
					</li>
					<li>
						ImageTargetFrameworkName: <xsl:value-of select="$settings/setting[@name='ImageTargetFrameworkName']/@value"/>
					</li>
					<li>
						ImageRequiresX86: <xsl:value-of select="$settings/setting[@name='ImageRequiresX86']/@value"/>
					</li>
					<li>
						ImageRequiresDefaultAppDomainAssemblyResolver: <xsl:value-of select="$settings/setting[@name='ImageRequiresDefaultAppDomainAssemblyResolver']/@value"/>
					</li>
					<li>
						NumberOfTestWorkers: <xsl:value-of select="$settings/setting[@name='NumberOfTestWorkers']/@value"/>
					</li>
				</ul>
				
				<div>
					<!-- Tests Run -->
					<xsl:if test="//test-case[@result='Passed']">
						<h4>Tests Run</h4>
						<a href="#" id="showhide">Show/Hide All Results</a>
						<ol>
							<xsl:apply-templates select="//test-case[@result='Passed']"/>
						</ol>
					</xsl:if>
				</div>
        
        <!-- JavaScript dependencies for jquery, popper and bootstrap -->
				<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
				<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
				<!-- Collapse/Expand javascript click event -->
        <script type="text/javascript">
					$('#showhide').click(function (){
						$('.collapse').collapse('toggle');
					});
				</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="test-case">
		<!-- Determine type of test-case for formatting -->
		<xsl:variable name="type">
			<xsl:choose>
				<xsl:when test="@result='Passed'">
					<xsl:choose>
						<xsl:when test="@label='Ignored' or @label='Explicit'">
							<xsl:value-of select="@label"/>
						</xsl:when>
						<xsl:otherwise>			
							<xsl:value-of select="'Passed'" />			
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="@result='Skipped'">
					<xsl:choose>
						<xsl:when test="@label='Ignored' or @label='Explicit'">
							<xsl:value-of select="@label"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Other'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="@result='Failed'">
					<xsl:choose>
						<xsl:when test="@label='Error' or @label='Invalid'">
							<xsl:value-of select="@label"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'Failed'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Unknown'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Show details of test-cases either skipped or errored -->
		<li>
			<xsl:choose>
				<xsl:when test="$type='Passed'">
					<span class="passed">
						<xsl:value-of select="$type" />
					</span>			
				</xsl:when>
			</xsl:choose>
			<span class="test-name">
				<a href="#{generate-id(@methodname)}" data-bs-toggle="collapse">
					<xsl:value-of select="@methodname" />
				</a>
			</span>
			<div id="{generate-id(@methodname)}" class="collapse">
				<div class="card card-body">     
					<pre>
						<xsl:value-of select="child::node()"/>
						<xsl:choose>
							<xsl:when test="$type='Failed'">
								<br/>
							</xsl:when>
							<xsl:when test="$type='Error'">
								<br/>
							</xsl:when>
						</xsl:choose>

						<!-- Stack trace for failures -->
						<xsl:if test="failure and ($type='Failed' or $type='Error')">
							<xsl:value-of select="failure/stack-trace"/>
						</xsl:if>
					</pre>
				</div>
			</div>
		</li>
	</xsl:template>

</xsl:stylesheet>