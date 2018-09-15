#!/usr/bin/env groovy
@Grapes([
    @Grab(group='commons-io', module='commons-io', version='2.6')
])

import groovy.text.StreamingTemplateEngine
import org.apache.commons.io.*

def baseProjectDir = FilenameUtils.normalize(new File('../../').getAbsolutePath())
def outDir = new File('./out')

if (outDir.exists()) {
   FileUtils.forceDelete(outDir)
}

outDir.mkdir()

def transformedTemplate = new File('./in/rancher-cluster.yml').withReader { reader ->
   def template = new StreamingTemplateEngine().createTemplate(reader)
   
   return template.make([
      'baseProjectDir': baseProjectDir
   ])
}

new File(outDir, 'cluster.yml').append(transformedTemplate)
