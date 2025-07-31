# OmniStudio FlexCard Development Guide

## Overview
This guide provides developers with the essential information needed to build OmniStudio FlexCards with actions in the TheKenificGroup project.

## Development Environment Setup

### Prerequisites
- Salesforce CLI installed and configured
- OmniStudio package installed in target org
- Visual Studio Code with Salesforce extensions
- Git configured for version control

### Project Structure
```
TheKenificGroup/
├── force-app/main/default/
│   ├── omniUiCard/                    # FlexCard definitions
│   ├── omniDataTransform/             # DataRaptors for data retrieval
│   ├── omniIntegrationProcedure/      # Integration Procedures for actions
│   ├── lwc/                           # Custom Lightning Web Components
│   └── classes/                       # Apex classes for custom logic
├── docs/                              # Project documentation
├── manifest/                          # Deployment manifests
└── omnistudio-package.xml             # OmniStudio-specific manifest
```

## FlexCard Development Workflow

### 1. Planning Phase
- Review user story requirements
- Design card layout and actions
- Identify data sources needed
- Plan Integration Procedures for actions

### 2. Data Layer Development
- Create DataRaptors for data retrieval
- Test data transformations
- Optimize queries for performance

### 3. FlexCard Creation
- Use FlexCard Designer in Salesforce
- Configure card layout and styling
- Add data sources and field mappings
- Implement conditional visibility rules

### 4. Action Implementation
- Create Integration Procedures for complex actions
- Configure action buttons and menus
- Add validation and error handling
- Test action workflows

### 5. Testing and Validation
- Unit test DataRaptors and Integration Procedures
- User acceptance testing with stakeholders
- Performance testing for large datasets
- Cross-browser and mobile testing

## FlexCard Best Practices

### Design Guidelines
- **Keep cards focused:** Each card should serve a specific purpose
- **Prioritize information:** Show the most important data prominently
- **Use consistent styling:** Follow Salesforce Lightning Design System
- **Optimize for mobile:** Ensure cards work well on all screen sizes

### Performance Optimization
- **Limit data retrieval:** Only fetch necessary fields
- **Use caching:** Enable appropriate caching strategies
- **Optimize images:** Compress and size images appropriately
- **Test with large datasets:** Validate performance with realistic data volumes

### Action Design
- **Make actions discoverable:** Use clear labels and icons
- **Provide feedback:** Show loading states and success/error messages
- **Handle errors gracefully:** Display meaningful error messages
- **Respect permissions:** Only show actions users can perform

## Technical Implementation

### DataRaptor Configuration
```json
{
  "name": "AccountCardData",
  "type": "Extract",
  "sourceObject": "Account",
  "fields": [
    "Id",
    "Name",
    "Phone",
    "Industry",
    "AnnualRevenue",
    "Owner.Name"
  ]
}
```

### Integration Procedure Structure
```json
{
  "name": "UpdateAccountStatus",
  "elements": [
    {
      "type": "DataRaptor Extract",
      "name": "GetAccountData"
    },
    {
      "type": "Set Values",
      "name": "ValidateInput"
    },
    {
      "type": "DataRaptor Transform",
      "name": "UpdateAccount"
    }
  ]
}
```

### FlexCard Action Configuration
```json
{
  "actionType": "Integration Procedure",
  "integrationProcedure": "UpdateAccountStatus",
  "label": "Update Status",
  "parameters": {
    "accountId": "{Id}",
    "newStatus": "{selectedStatus}"
  }
}
```

## Testing Strategy

### Unit Testing
- Test DataRaptors with various input scenarios
- Validate Integration Procedure logic
- Test conditional visibility rules

### Integration Testing
- End-to-end action workflows
- Data flow between components
- External system integrations

### User Acceptance Testing
- Stakeholder review sessions
- Real-world usage scenarios
- Performance under normal load

## Deployment Process

### Development to Testing
```bash
# Retrieve latest changes
sf project retrieve start --manifest omnistudio-package.xml

# Deploy to test environment
sf project deploy start --manifest omnistudio-package.xml --target-org test
```

### Testing to Production
```bash
# Create deployment package
sf project deploy start --manifest omnistudio-package.xml --target-org production --check-only

# Deploy to production
sf project deploy start --manifest omnistudio-package.xml --target-org production
```

## Troubleshooting

### Common Issues
1. **Card not displaying data:**
   - Check DataRaptor configuration
   - Verify object permissions
   - Review field-level security

2. **Actions not working:**
   - Validate Integration Procedure logic
   - Check user permissions
   - Review action configuration

3. **Performance issues:**
   - Optimize DataRaptor queries
   - Reduce data payload size
   - Enable appropriate caching

### Debug Tools
- Salesforce Developer Console
- OmniStudio Debug Mode
- Browser Developer Tools
- Salesforce Inspector Extension

## Code Review Checklist

### Functionality
- [ ] Requirements met according to user story
- [ ] Actions work as expected
- [ ] Error handling implemented
- [ ] Performance optimized

### Code Quality
- [ ] Follows naming conventions
- [ ] Proper documentation included
- [ ] No hardcoded values
- [ ] Reusable components created

### Security
- [ ] User permissions respected
- [ ] Input validation implemented
- [ ] No sensitive data exposed
- [ ] CRUD/FLS checks in place

### Testing
- [ ] Unit tests written and passing
- [ ] Integration tests completed
- [ ] User acceptance criteria met
- [ ] Cross-browser testing done

## Resources

### Documentation
- [OmniStudio FlexCards Documentation](https://help.salesforce.com/s/articleView?id=sf.os_flexcards.htm)
- [Integration Procedures Guide](https://help.salesforce.com/s/articleView?id=sf.os_integration_procedures.htm)
- [DataRaptor Documentation](https://help.salesforce.com/s/articleView?id=sf.os_data_raptors.htm)

### Training
- Salesforce Trailhead OmniStudio modules
- OmniStudio Developer Certification
- Lightning Web Components training

### Community
- Salesforce Developer Community
- OmniStudio Trailblazer Community
- Stack Overflow Salesforce tags