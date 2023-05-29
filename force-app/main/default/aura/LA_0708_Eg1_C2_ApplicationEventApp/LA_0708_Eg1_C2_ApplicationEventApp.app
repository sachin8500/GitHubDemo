<aura:application extends="force:slds">
    
    <lightning:layout>
            <lightning:layoutItem size="4">
        <lightning:card title="Search Account" >    
        	<c:LC_0708_Eg1_C1_ApplicationEvent />
            </lightning:card>
        </lightning:layoutItem>   
    
    
            
        <lightning:layoutItem size="4">
        <lightning:card title="Contacts" >    
        	    <c:LC_0708_Eg1_C2_ApplicationEventDisplay />

            </lightning:card>
        </lightning:layoutItem>   
        
           <lightning:layoutItem size="4">
        <lightning:card title="Opportunities" >    
        	    <c:LC_0708_Eg1_C3_ApplicationEventDisplay />

            </lightning:card>
        </lightning:layoutItem>  
    </lightning:layout>

    
        
    

</aura:application>