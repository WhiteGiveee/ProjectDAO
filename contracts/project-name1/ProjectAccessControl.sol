// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "../AccessControl.sol";
import "../IAccessControl.sol";


contract ProjectAccessControl is AccessControl{

    IAccessControl private daoAccessControl;

    constructor(address daoAccessControlAddress) {
        _initialize();
        daoAccessControl = IAccessControl(daoAccessControlAddress);
    }

    modifier allowPermission(bytes32 objectPermission, bytes32 organizationPermission) {
        require(
            _check(objectPermission, msg.sender) || daoAccessControl.inquiryAccountPermission(organizationPermission, msg.sender), 
            "AccessControl: You have no permission to access this function."
        );
        _;
    }

    function createPermission(bytes memory permissionName) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._createPermission(permissionName);
    }

    function createPermissionByLevel(bytes memory permissionName, bytes memory permissionAlready) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._createPermissionByLevel(permissionName, permissionAlready);
    }

    function deletePermission(bytes memory permissionName) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._deletePermission(permissionName);
    }

    function grantAccountPermission(bytes memory permissionName, address account) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._grantAccountPermission(permissionName, account);
    }

    function revokeAccountPermission(bytes memory permissionName, address account) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._revokeAccountPermission(permissionName, account);
    }

    function deleteAccount(address account) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._deleteAccount(account);
    }

    function transferAdmin(address account) 
        public allowPermission(ACCESS_MANAGER, ADMIN) 
    {
        AccessControl._transferAdmin(account);
    }

    function inquiryAccountPermission(bytes32 permission, address account) 
        public view allowPermission(STAFF, STAFF) returns (bool) 
    {
        return AccessControl._inquiryAccountPermission(permission, account);
    }

    function inquiryAllAccountsByPermission(bytes32 permission) 
        public view allowPermission(STAFF, STAFF) returns (address[] memory) 
    {
        return AccessControl._inquiryAllAccountsByPermission(permission);
    }

    function inquiryAllPermissionsByAccount(address account) 
        public view allowPermission(STAFF, STAFF) returns (bytes32[] memory) 
    {
        return AccessControl._inquiryAllPermissionsByAccount(account);
    }

    function inquiryAdmin() public view allowPermission(STAFF, STAFF) returns (address) {
        return AccessControl._inquiryAdmin();
    }

}