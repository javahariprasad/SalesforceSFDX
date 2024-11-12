<aura:application extends="ltng:outApp" >
	<aura:attribute name="greeting" type="String" default="Hello" access="global" />
    <aura:attribute name="subject" type="String" default="World" access="global" />

    <div style="box">
      <span class="greeting">{!v.greeting}</span>, {!v.subject}!
    </div>
</aura:application>