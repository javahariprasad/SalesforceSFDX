public class samplecomp {
/*<!--
  @Component Name     : Case_DocumentExchangev2.cmp
  @Description        : Component is used to upload multiple files for creating child and parent cases.  
  @Author             : Sandeep  
  @Modification Log   : 
  ==============================================================================
  Ver         Date                     Author      		      Modification
  ==============================================================================
  1.0    6/18/2019, 6:29:04 PM   Sandeep     Initial Version
  1.0    6/20/2019, 6:29:04 PM   Hari Prasad     Added Spinner and Async functionality
  2.0    08/08/2019              Hari Prasad     Added/created custom component for captcha to resuse multiple applications.
-->
<aura:component controller="Case_DocX_Controller_v2" implements="force:appHostable,flexipage:availableForAllPageTypes,flexipage:availableForRecordHome,force:hasRecordId,forceCommunity:availableForAllPageTypes,force:lightningQuickAction" access="global" >
    <aura:attribute name="maxFiles" type="Integer" default="5"/>
    <aura:attribute name="defaultFiles" type="Integer" default="1"/>
    <aura:attribute name="maxFileSize" type="Integer" default="3"/>
    <aura:attribute name="accept" type="String" default=".pdf, .jpg, .png, .doc"/>
    
    <aura:attribute name="files" type="List" default="[]"/>
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>
    <aura:attribute name="conversion" type="ContentVersion" default="{'sobjectType': 'ContentVersion'}" access="global"/>
    <aura:attribute name="newCase" type="Case" default="{'sobjectType': 'Case'}" access="global" />
    <aura:attribute name="docCategoryOptions" type="Object" />
    <aura:attribute name="mastDocTypeOptions" type="Object" />
    <aura:attribute name="parentCaseId" type="String" />
    <aura:attribute name="bfiles" type="List" default="[]"/>
    
    <aura:attribute name="Spinner" type="boolean" default="false"/>
    <aura:handler event="aura:waiting" action="{!c.showSpinner}"/>
    <aura:handler event="aura:doneWaiting" action="{!c.hideSpinner}"/>
    <aura:attribute name="listConversion" type="List" access="global"/>
    <aura:attribute name="SpinnerResults" type="boolean" default="true"/>
    <aura:attribute name="bCaptcha" type="String" default="true"/>
    <aura:attribute name="label" type="string" default=""/>
    <aura:attribute name="showSubmit" type="boolean" default="true"/>

    <lightning:layout>
        <lightning:layoutItem size="2"></lightning:layoutItem>
        <lightning:layoutItem size="8">
            <lightning:layout multipleRows="True">
                <lightning:layoutItem size="12" class="slds-p-around_small">
                    <div class="slds-text-heading_large slds-m-top_medium">
                        <aura:unescapedHtml value="{!$Label.c.Header1}"/>
                    </div>
                    <div class="slds-text-heading-xx_small slds-m-top_medium">
                        <aura:unescapedHtml value="{!$Label.c.Multiple_Files}"/>
                    </div>
                    <div class="slds-text-heading-xx_small slds-m-top_medium">
                        <aura:unescapedHtml value="{!$Label.c.Header3}"/>
                    </div>
                </lightning:layoutItem>
                <lightning:layoutItem class="slds-p-around_small" size="6">
                    <lightning:input aura:id="fName" label="First Name" required="true" messageWhenValueMissing="Please enter your first name" value="{!v.newCase.First_Name__c}"/>
                </lightning:layoutItem>
                <lightning:layoutItem class="slds-p-around_small" size="6">
                    <lightning:input aura:id="lName" label="Last Name" required="true" messageWhenValueMissing="Please enter your last name" value="{!v.newCase.Last_Name__c}" />
                </lightning:layoutItem>
                <lightning:layoutItem class="slds-p-around_small" size="6">
                    <lightning:input aura:id="email" label="Email" value="{!v.newCase.SuppliedEmail}" required="true" messageWhenValueMissing="Please enter your email address"/>
                </lightning:layoutItem>
            </lightning:layout>
            <aura:iteration items="{!v.files}" var="file" indexVar="rowCount">
                <div class="slds-m-vertical_x-small slds-p-bottom_small slds-m-left_small slds-border_bottom">
                    <div class="slds-float--left slds-m-top_small  slds-size--11-of-12"><b>File # {!file.rowCount}</b></div>
                    <div class="slds-float--left slds-m-left_small">
                        <aura:if isTrue="{!file.rowCount != 1}">
                            <lightning:buttonIcon name="{!file.rowCount}" class="slds-m-left_medium" iconName="utility:delete" onclick="{!c.removeRow}"/>
                        </aura:if>
                    </div>
                    <div class="slds-clearfix"></div>
                </div>
                <lightning:layout multipleRows="True">
                    <lightning:layoutItem class="slds-p-around_small" size="6">
                        <lightning:select name="{!file.rowCount}" aura:id="conCategory" label="Category" value="{!file.selectedCategory}" onchange="{!c.getDocTypeValsOnCategory}">
                            <aura:iteration items="{!v.docCategoryOptions}" var="item">
                                <option value="{!(item == 'Select..' ? '' : item)}">{!item}</option>
                            </aura:iteration>
                        </lightning:select>
                    </lightning:layoutItem>
                    <lightning:layoutItem class="slds-p-around_small" size="6">
                        <lightning:select aura:id="DocType" label="Document Type" required="true" value="{!file.selectedType}" messageWhenValueMissing="Please select a document type">
                            <aura:iteration items="{!file.typeOptions}" var="item">
                                <option value="{!(item == 'Select..' ? '' : item)}">{!item}</option>
                            </aura:iteration>
                        </lightning:select>
                    </lightning:layoutItem>
                    <lightning:layoutItem class="slds-p-around_small" size="6">
                   <aura:if isTrue="{!(rowCount == 0)}">  
                            <lightning:input name="1" type="file" files="{!file.fileToBeUploaded}" aura:id='fileAttr1'  label="Attachment" multiple="false" accept="{!v.accept}" onchange="{!c.setLabel}"/>
                        </aura:if> 
                        <aura:if isTrue="{!(rowCount == 1)}">   
                            <lightning:input name="2" type="file" files="{!file.fileToBeUploaded}" aura:id='fileAttr2'  label="Attachment" multiple="false" accept="{!v.accept}" onchange="{!c.setLabel}"/>
                        </aura:if>
                        <aura:if isTrue="{!(rowCount == 2)}">   
                            <lightning:input  name="3" type="file" files="{!file.fileToBeUploaded}" aura:id='fileAttr3'  label="Attachment" multiple="false" accept="{!v.accept}" onchange="{!c.setLabel}" />
                        </aura:if>
                        <aura:if isTrue="{!(rowCount == 3)}">   
                            <lightning:input name="4" type="file" files="{!file.fileToBeUploaded}" aura:id='fileAttr4'  label="Attachment" multiple="false" accept="{!v.accept}" onchange="{!c.setLabel}"/>
                        </aura:if>
                        <aura:if isTrue="{!(rowCount == 4)}">   
                            <lightning:input name="5" type="file" files="{!file.fileToBeUploaded}" aura:id='fileAttr5'  label="Attachment" multiple="false" accept="{!v.accept}" onchange="{!c.setLabel}"/>
                        </aura:if>
                        <lightning:layoutItem class="slds-p-around_small" size="6"></lightning:layoutItem>
                        <lightning:layoutItem class="slds-p-around_small slds-size--12-of-12">
                            <div>
                                <aura:unescapedHtml value="{!$Label.c.Files_Acceptable}"/>
                            </div>
                        </lightning:layoutItem>
                    </lightning:layoutItem>
                    <lightning:layoutItem class="slds-p-around_small" size="6"></lightning:layoutItem>
                    <lightning:layoutItem class="slds-p-around_small" size="12">
                        <aura:if isTrue="{!file.selectedfile!=''}"> 
						<p> {!file.selectedfile} <lightning:buttonIcon name="{!file.rowCount}" class="slds-m-left_medium" iconName="utility:delete" onclick="{!c.removeAttachment}"/> </p>
                        </aura:if>
                    </lightning:layoutItem>
                </lightning:layout>
            </aura:iteration> 
            <aura:if isTrue="{!v.Spinner}">
                <div aura:id="spinnerId" class="slds-spinner_container">
                    <div class="slds-spinner--brand  slds-spinner slds-spinner--large slds-is-relative" role="alert">
                        <span class="slds-assistive-text">Loading</span>
                        <div class="slds-spinner__dot-a"></div>
                        <div class="slds-spinner__dot-b"></div>
                    </div>
                </div>
            </aura:if>
            <lightning:layout multipleRows="True">
              <aura:if isTrue="{!(v.maxFiles - v.files.length) > 0}">
                <lightning:LayoutItem padding="around-small" size="12">
                    <div class="slds-theme_shade slds-clearfix">
                        <div class="slds-float_left slds-media slds-media_center">
                            <div class="slds-media__figure">
                                <lightning:icon iconName="action:new" size="xx-small" onclick="{!c.addRow}"/>
                            </div>
                            <div class="slds-media__body">
                                <p>Upload another document ({!v.maxFiles - v.files.length} Left)</p>
                            </div>
                        </div>
                    </div>
                </lightning:LayoutItem>
                </aura:if>
                <lightning:layoutItem class="slds-p-around_small" size="12">
                    <div>
                        <div class="slds-float_left">
                        	<lightning:input type="checkbox" checked="{!v.newCase.User_Consent__c}" aura:id="ack" name="Acknowledgement"/>
                        </div>
                        <div class="slds-float_left slds-size--11-of-12">
                        	<aura:unescapedHtml value="{!$Label.c.Acknowledgement}"/>
                        </div>                        
                        <div class="slds-clearfix"></div>
                    </div>
                </lightning:layoutItem>
                <aura:if isTrue="{!v.bCaptcha}">
                    <c:GoogleReCaptcha  aura:id="gCaptcha"/> 
                 </aura:if>
                <lightning:layoutItem class="slds-p-around_large" size="12">
                <aura:if isTrue="{!v.showSubmit}">
                    <lightning:button variant="brand" label="Submit" onclick="{!c.save}"  aura:id="savebtn"/>
                   </aura:if>
                </lightning:layoutItem>
            </lightning:layout>
        </lightning:layoutItem>
        <lightning:layoutItem class="slds-size--2-of-12"></lightning:layoutItem>
    </lightning:layout>
</aura:component>
 */
}