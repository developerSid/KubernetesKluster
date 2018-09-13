@Grapes(
    @Grab(group='commons-codec', module='commons-codec', version='1.11')
)

import groovy.text.StreamingTemplateEngine
import org.apache.commons.codec.binary.Base64

def caCert = Base64.encodeBase64String(new File('../../Certificates/vagrant/out/ca.pem').getBytes())
def caCertKey = Base64.encodeBase64String(new File('../../Certificates/vagrant/out/ca-key.pem').getBytes())
def masterCert = Base64.encodeBase64String(new File('../../Certificates/vagrant/out/master.vagrant.example.pem').getBytes())
def masterCertKey = Base64.encodeBase64String(new File('../../Certificates/vagrant/out/master.vagrant.example-key.pem').getBytes())