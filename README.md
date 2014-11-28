#Mobile Singleselect - Extension for the module "mobile" for SpatialSuite
===
## Content

#### 1. Description
#### 2. License
#### 3. Installation

## 1. Description
Spatial Suite module that changes the default behavior of the search function to search in 
a single datasource

## 2. License
 Name:        Mobile Singleselect for SpatialSuite  
 Purpose:     Extension for the module "mobile" for Spatial Map. This module requires the standard "mobile" module for Spatial Map

 Author:      karsten(AT)septima.dk
  
 Created:     03-09-2013  
 Copyright:   (c) Septima P/S 2013  
 Licence:     Commercially licensed product. Please contact Septima to obtain
              a valid license.
              You are granted the right to download and install this module for
              evaluation purposes free of charge.
              
 Contact:     Septima P/S  
              Frederiksberggade 28, 2.tv.  
              1459 København K  
              www.septima.dk  
              kontakt@septima.dk  

## 3. Installation

NOTE: 
Never change the mobile-singleselect module. Instead, create a custom module with changes only.
The module is based on the "mobile" module for Spatial Map 2.10 but will probably work with older and newer versions.


### 3.a Get mobile-singleselect module:
Latest version is always located at:  
      https://github.com/Septima/spatialsuite-mobile-singleselect/archive/master.zip  
            
### 3.a Unzip and copy the module to [cbinfo.config.dir]/modules/septima/mobile-singleselect

### 3.b Update modules.xml by adding:
```xml
<module name="mobile-singleselect" dir="septima/mobile-singleselect" permissionlevel="public"/>
```
### 3.c Add a command called "mobile-search" to your datasource like this:
```xml
     <sql command="mobile-search" keepunresolved="false">SELECT skoleid as displayname, wkb_geometry as shape_wkt FROM skoler WHERE skoleid like [string:'%'+searchstring+'%'] limit [number: toNumber(limit)]</sql>
```
It is important that the select returns "displayname" and "shape_wkt"!

### 3.d To show a profile on a mobile device, use a URL like this:
        http://HOST/cbkort?page=mobile-content-singleselect&profile=XXXXX&datasource=YYYYYY

