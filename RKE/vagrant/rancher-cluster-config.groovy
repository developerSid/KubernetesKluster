@Grapes([
    @Grab(group='commons-codec', module='commons-codec', version='1.11'),
    @Grab(group='commons-io', module='commons-io', version='2.6')
])

import groovy.text.StreamingTemplateEngine
import org.apache.commons.io.*
import org.apache.commons.codec.binary.Base64
import java.nio.file.Paths

def baseProjectDir = FilenameUtils.normalize(new File('../../').getAbsolutePath())
def outDir = new File('./out')

if (outDir.exists()) {
   FileUtils.forceDelete(outDir)
}

outDir.mkdir()

def caCert = Base64.encodeBase64String(new File("$baseProjectDir/Certificates/vagrant/out/ca.pem").getBytes())
def masterCert = Base64.encodeBase64String(new File("$baseProjectDir/Certificates/vagrant/out/master.vagrant.example.pem").getBytes())
def masterCertKey = Base64.encodeBase64String(new File("$baseProjectDir/Certificates/vagrant/out/master.vagrant.example-key.pem").getBytes())

def transformedTemplate = new File('./in/rancher-cluster.yml').withReader { reader ->
   def template = new StreamingTemplateEngine().createTemplate(reader)
   
   return template.make([
      'baseProjectDir': baseProjectDir,
      'caCert': caCert,
      'masterCert': masterCert,
      'masterCertKey': masterCertKey
   ])
}

new File(outDir, 'cluster.yml').append(transformedTemplate)
