<div align="center" class="DNSHome">
	{%if isset|Domain == false}
		<div class="simplebox grid740">
			<div class="titleh">
				<h3>DNS Domain Selection</h3>
				<div class="shortcuts-icons">
					<a class="shortcut tips" id="NewUserOpen" title="Add User"><img src="./templates/blue_default/img/icons/shortcut/addfile.png" width="25" height="25" alt="icon" /></a>
				</div>
			</div>
			<table id="UserTable" class="tablesorter"> 
				<thead> 
					<tr> 
						<th style="width:100%">Domain</th> 
					</tr> 
				</thead> 
				<tbody>
					{%if isset|DomainList == false}
						<tr>
							<td>
								<div align="center">You must add a domain before you can add DNS records.</div>
							</td>
						</tr>
					{%/if}
					{%if isset|DomainList == true}
						{%foreach entry in DomainList}
							<tr>
								<td><a href="dns.php?domain={%?entry}">{%?entry}</a></td>
							</tr>
						{%/foreach}
					{%/if}
				</tbody> 
			</table>
		</div>
	{%/if}
	{%if isset|Domain == true}
	
	{%/if}
</div>