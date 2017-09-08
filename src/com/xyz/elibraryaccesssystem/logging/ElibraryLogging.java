/**
 * 
 */
package com.xyz.elibraryaccesssystem.logging;

import java.net.URL;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.helpers.Loader;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;


/**
 * @author sv812067
 *
 */

@Aspect
public class ElibraryLogging 
{

	
	
	@Pointcut("execution(* com.xyz.elibraryaccesssystem.dao.*.*.*(..))")
	public void configure(){ }
	
	
	@Before("configure()")
    public void configureLogging() throws Throwable {
         Object point = null;
         Logger myLog = Logger.getLogger(ElibraryLogging.class);
         
         URL url=Loader.getResource("log4j.properties");
         PropertyConfigurator.configure(url.getFile());
         
         try {
               System.out.println("from logging aspect: entering method");
               myLog.info("Logged in at" + new java.util.Date().toString());
               System.out.println("from logging aspect: exiting method ");
         } catch (Exception e) {
               System.out.println("Exception occured");
      }
     
  }
}
