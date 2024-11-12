<aura:application extends="ltng:outApp" >
	<ui:inputText aura:id="name" label="Enter Name:" placeholder="Your Name" />
	<ui:button aura:id="button" buttonTitle="Click to see what you put into the field" class="button" label="Click me" press="{!c.getInput}"/>
	<ui:outputText aura:id="outName" value="" class="text"/>
</aura:application>