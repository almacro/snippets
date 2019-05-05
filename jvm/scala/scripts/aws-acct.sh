#!/bin/sh
exec scala -classpath $AWS_SDK_HOME/lib/aws-java-sdk-1.11.234.jar:./lib/snakeyaml-1.19.jar:./lib/commons-logging-1.2.jar:./lib/commons-logging-api-1.1.jar:./lib/jackson-databind-2.6.7.1.jar:./lib/jackson-core-2.6.7.jar:./lib/jackson-annotations-2.6.0.jar:./lib/httpclient-4.5.2.jar:./lib/httpcore-4.4.4.jar:./lib/joda-time-2.9.9.jar:./lib/commons-net-3.6.jar "$0" "$@"
!#

import java.nio.file.{Files, Path, Paths, StandardOpenOption}

import scala.collection.JavaConverters._
import scala.language.postfixOps

import org.yaml.snakeyaml.{DumperOptions, Yaml}

// constant values
object V {
  val creds = "./.creds"
}


// utils
object U {
  def getTopKey(m: java.util.Map[String,java.util.List[java.util.Map[String,String]]]) = m.keySet.asScala.head

  def toInputStream(p: Path) = Files.newInputStream(p, StandardOpenOption.READ)

  def toFileName(p: Path) = p.getFileName

  def truncExt(p:Path) = toFileName(p).toString.split("\\.").head

  def excerptText(text: String) = text.substring(0,4) + "..." + text.substring(text.size-4,text.size)

  def now = ""+java.time.LocalDateTime.now

  def bars = { "=" * 40 }

  def prependCommaList(ss: Iterable[String]) = {
    Stream.continually(",") zip ss 
  } map {
    (a:(String,String)) => s"${a._1} ${a._2}"
  } mkString ""

  def buildKVs(m: Map[String,String]) = {
   prependCommaList{ for { (k,v) <- m if k != "account" } 
         yield String.format("%s: %s", k, v) } 
  }

  def report(subj: String) = List(bars,subj,bars).mkString("\n")
  def subject(t:String, m: Map[String,String]) = t + " for " +  m("account") + buildKVs(m + ("timestamp" -> now)) 

  def _header(t:String, m: Map[String,String]) = report( "BEGIN " + subject(t,m) )
  def _footer(t:String, m: Map[String,String]) = report( "END "   + subject(t,m) ) 

  def header = _header _ tupled
  def footer = _footer _ tupled
}

// Yaml singelton
object Y {
  private val inst = {
    val opts = new DumperOptions()
    opts.setDefaultFlowStyle(DumperOptions.FlowStyle.BLOCK);
    val y = new Yaml(opts)
    y
  }
  def get() = inst
}

class S3(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access, secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.s3.AmazonS3Client.builder
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build
  }
  def get() = inst
  def forRegion(aRegion: String) = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access, secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.s3.AmazonS3Client.builder
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(aRegion))
      .build
  }
}

class EC2(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.ec2.AmazonEC2ClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class ELB(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.elasticloadbalancingv2.AmazonElasticLoadBalancingClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class EFS(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.elasticfilesystem.AmazonElasticFileSystemClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class Lambda(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.lambda.AWSLambdaClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class Route53(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.route53.AmazonRoute53ClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class IAM(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.identitymanagement.AmazonIdentityManagementClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class ECS(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.ecs.AmazonECSClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class ECR(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.ecr.AmazonECRClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class RDS(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.rds.AmazonRDSClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build      
  }
  def get() = inst
}

class SQS(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.sqs.AmazonSQSClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build
  }
  def get() = inst
}

class SES(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceAsyncClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build
  }
  def get() = inst
}

class SNS(access: String, secret: String, region: String) {
  private val inst = {
    val creds = new com.amazonaws.auth.BasicAWSCredentials(access,secret)
    val provider = new com.amazonaws.auth.AWSStaticCredentialsProvider(creds)
    com.amazonaws.services.sns.AmazonSNSClientBuilder.standard
      .withCredentials(provider)
      .withRegion(com.amazonaws.regions.Regions.fromName(region))
      .build
  }
  def get() = inst
}

class Account(conf: Path) {
  private val _om = Y.get()
    .load( U.toInputStream(conf) )
    .asInstanceOf[java.util.Map[String,java.util.List[java.util.Map[String,String]]]]

  private val _top = U.getTopKey(_om)

  private val _lis = _om.get(_top)

  private val _m = _lis.asScala.map(_.asScala).flatten.toMap +
      ("account_id" -> _top) +
      ("domain" -> U.truncExt(conf))

  def getAccessKey = _m("access")
  def getAccountId = _m("account_id")
  def getDomain = _m("domain")
  //def getRegion = _m("region")
  // us-east-1 us-east-2 us-west-1 us-west-2
  def getRegion = "us-west-2"
  def getSecretAccessKey = _m("secret")

  private val _S3      = new S3(getAccessKey, getSecretAccessKey, getRegion)
  private val _EC2     = new EC2(getAccessKey, getSecretAccessKey, getRegion)
  private val _ELB     = new ELB(getAccessKey, getSecretAccessKey, getRegion)
  private val _EFS     = new EFS(getAccessKey, getSecretAccessKey, getRegion)
  private val _Lambda  = new Lambda(getAccessKey, getSecretAccessKey, getRegion)
  private val _Route53 = new Route53(getAccessKey, getSecretAccessKey, getRegion)
  private val _IAM     = new IAM(getAccessKey, getSecretAccessKey, getRegion)
  private val _ECS     = new ECS(getAccessKey, getSecretAccessKey, getRegion)
  private val _ECR     = new ECR(getAccessKey, getSecretAccessKey, getRegion)
  private val _RDS     = new RDS(getAccessKey, getSecretAccessKey, getRegion)
  private val _SQS     = new SQS(getAccessKey, getSecretAccessKey, getRegion)
  private val _SES     = new SES(getAccessKey, getSecretAccessKey, getRegion)
  private val _SNS     = new SNS(getAccessKey, getSecretAccessKey, getRegion)

  private def mask = {
    val mm = collection.mutable.Map[String,String]() ++ _m
    mm("access") = U.excerptText(_m("access"))
    mm("secret") = U.excerptText(_m("secret"))
    mm
  }

  def toYaml = {
    Y.get().dump( mask.asJava )
  }

  def toRegion(r: String) = {
    //println("toRegion got arg "+r)
    if(r == "US") 
      "us-east-1" 
    else 
      r
  }

  override def toString = {
    mask.toString
  }

  def listS3buckets {
    val subject = "S3 buckets"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val s3 = _S3.get()
    val buckets = s3.listBuckets().asScala
    var t = 0
    for(b <- buckets) {
      println(b)
      //val region = toRegion(s3.getBucketLocation(b.getName))
      //val (totalObjects, totalBytes) = countTotalObjectsAndBytesStored(b, region)
      //println(s"  ${b.getName} stores $totalObjects total objects")
      //println(s"  ${b.getName} stores $totalBytes total bytes")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def countTotalObjectsAndBytesStored(bucket: com.amazonaws.services.s3.model.Bucket, region: String) = {
    def pause { Thread.sleep(10 * 1000L) }
    var c = 0
    var s:Long = 0
    val s3 = _S3.forRegion(region)
    var objs = s3.listObjects(bucket.getName)
    val summs = objs.getObjectSummaries()
    var it = summs.iterator()
    var summ: com.amazonaws.services.s3.model.S3ObjectSummary = null
    while(it.hasNext()) {
      summ = it.next()
      pause
      c += 1
      s += summ.getSize()
    }
    while(objs.isTruncated()) {
      objs = s3.listNextBatchOfObjects(objs)
      it = objs.getObjectSummaries().iterator()
      while(it.hasNext()) {
        summ = it.next()
        pause
        c += 1
        s += summ.getSize()
      }
    }
    (c,s)
  }

  def listEBSvolumes {
    val subject = "EBS volumes" 
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val vols = _EC2.get().describeVolumes().getVolumes().asScala
    var t = 0
    for(v <- vols) {
      println(v)
      // TODO get storage size of EBS volume
      println(s"  ${v.getSize} GiBs allocated on ${v.getVolumeId}")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listEC2instances {
    val subject = "EC2 instances"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val ec2s = _EC2.get().describeInstances().getReservations.asScala
    var t = 0
    for(e <- ec2s) {
      println(e)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listELBinstances = {
    val subject = "ELB instances"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val req = new com.amazonaws.services.elasticloadbalancingv2.model.DescribeLoadBalancersRequest()
    val elbs = _ELB.get().describeLoadBalancers(req).getLoadBalancers().asScala
    var t = 0
    for(e <- elbs) {
      println(e)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listEFSvolumes = {
    val subject = "EFS volumes"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    var t = 0
    if (List("us-east-1", "us-east-2", "us-west-2") contains getRegion) {
      val efs = _EFS.get().describeFileSystems().getFileSystems().asScala

      for(e <- efs) {
        println(e)
        println(s"  ${e.getName} stores ${e.getSizeInBytes} bytes")
        t += 1
      }
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listAMIs = {
    val subject = "AMI images"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val req = new com.amazonaws.services.ec2.model.DescribeImagesRequest().withOwners(getAccountId)
    val amis = _EC2.get().describeImages(req).getImages().asScala
    var t = 0
    for(a <- amis) {
      println(a)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listEBSsnapshots = {
    val subject = "EBS snapshots"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val req = new com.amazonaws.services.ec2.model.DescribeSnapshotsRequest().withOwnerIds(getAccountId)
    val ebs = _EC2.get().describeSnapshots(req).getSnapshots().asScala
    var t = 0
    for(e <- ebs) {
      println(e)
      // TODO get size of EBS snapshot
      println(s"  ${e.getVolumeSize} GiB allocated to store ${e.getSnapshotId}")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listLambdaFunctions = {
    val subject = "Lambda functions"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val lams = _Lambda.get().listFunctions().getFunctions().asScala
    var t = 0
    for(lam <- lams) {
      println(lam)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listIAMusers = {
    val subject = "IAM users"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val users = _IAM.get().listUsers().getUsers().asScala
    var t = 0
    for(u <- users) {
      println(u)
      t += 1     
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listIAMgroups = {
    val subject = "IAM groups"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val groups = _IAM.get().listGroups().getGroups().asScala
    var t = 0
    for(g <- groups) {
      println(g)
      t += 1     
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listIAMroles = {
    val subject = "IAM roles"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val roles = _IAM.get().listRoles().getRoles().asScala
    var t = 0
    for(r <- roles) {
      println(r)
      t += 1     
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listIAMpolicies = {
    val subject = "IAM policies"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val scope = com.amazonaws.services.identitymanagement.model.PolicyScopeType.Local
    val req = new com.amazonaws.services.identitymanagement.model.ListPoliciesRequest().withScope(scope)
    val policies = _IAM.get().listPolicies(req).getPolicies().asScala
    var t = 0
    for(p <- policies) {
      println(p)
      t += 1     
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listSecurityGroups = {
    val subject = "Security Groups" 
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val ebs = _EC2.get().describeSecurityGroups().getSecurityGroups().asScala
    var t = 0
    for(e <- ebs) {
      println(e)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )
  }

  def listSubnets = {
    val subject = "Subnets"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val nets = _EC2.get().describeSubnets().getSubnets().asScala
    var t = 0
    for(n <- nets) {
      println(n)
      // TODO get count of nodes on this subnet
      val cidrTotal = new org.apache.commons.net.util.SubnetUtils(n.getCidrBlock()).getInfo().getAddressCountLong()
      val cidrAvail = n.getAvailableIpAddressCount()
      println(s"  subnet ${n.getSubnetId} in VPC ${n.getVpcId} hosts ${cidrTotal-cidrAvail} nodes")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )    
  }


  def listElasticIPs = {
    def getAssoc(a: com.amazonaws.services.ec2.model.Address) = {
    val instId = a.getInstanceId
       instId match {
        case null => "not associated with an instance"
        case _ => s"associated with instance $instId"
      }
    }    
    val subject = "Elastic IPs"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val eips = _EC2.get().describeAddresses().getAddresses().asScala
    var t = 0
    for(eip <- eips) {
      println(eip)
      // TODO get ElasticIP association (e.g., EC2 instance)
      println("  this address is " + getAssoc(eip))
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )        
  }

  def listVPCs = {
    val subject = "VPCs"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val vpcs = _EC2.get().describeVpcs().getVpcs().asScala
    var t = 0
    for(v <- vpcs) {
      println(v)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listKeyPairs = {
    val subject = "Key Pairs"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val kps = _EC2.get().describeKeyPairs().getKeyPairs().asScala
    var t = 0
    for(kp <- kps) {
      println(kp)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listRt53hostedZones = {
    val subject = "rt53 Hosted Zones"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val zones = _Route53.get().listHostedZones().getHostedZones().asScala
    var t = 0
    var trecs = List[com.amazonaws.services.route53.model.ResourceRecordSet]()
    for(zone <- zones) {
      println(zone)
      val req = new com.amazonaws.services.route53.model.ListResourceRecordSetsRequest().withHostedZoneId(zone.getId())
      val recs = _Route53.get().listResourceRecordSets(req).getResourceRecordSets().asScala
      t += 1
      trecs = trecs ++ recs
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    listRt53recordSets(trecs)
    println( U.footer(topic) )            
  }

  def listRt53recordSets(recsets: List[com.amazonaws.services.route53.model.ResourceRecordSet]) = {
    val subject = "rt53 Record Sets"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    var t = 0
    for(recset <- recsets) {
      println(recsets)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listECSclusters = {
    val subject = "ECS clusters"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val ecs = _ECS.get().listClusters().getClusterArns().asScala
    var t = 0
    for(e <- ecs) {
      println(e)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listECStaskdefs = {
    val subject = "ECS task definitions"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val taskdefs = _ECS.get().listTaskDefinitions().getTaskDefinitionArns().asScala
    var t = 0
    for(taskdef <- taskdefs) {
      println(taskdef)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )                
  }

  def listECSservices = {
    val subject = "ECS services"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val svcs = _ECS.get().listServices().getServiceArns().asScala
    var t = 0
    for(svc <- svcs) {
      println(svc)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )                
  }

  def listECRs = {
    val subject = "ECS registries"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val req = new com.amazonaws.services.ecr.model.GetAuthorizationTokenRequest().withRegistryIds(getAccountId)
    val ecrs = _ECR.get().getAuthorizationToken(req).getAuthorizationData().asScala
    var t = 0
    for(r <- ecrs) {
      println(r.getProxyEndpoint)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listRDSinstances = {
    val subject = "RDS instances"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val dbs = _RDS.get().describeDBInstances().getDBInstances().asScala
    var t = 0
    for(db <- dbs) {
      println(db)
      // TODO get total bytes stored in db instance
      println(s"  $db stores ${db.getAllocatedStorage()} GiB")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listRDSsnapshots = {
    val subject = "RDS snapshots"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val dbs = _RDS.get().describeDBSnapshots().getDBSnapshots().asScala
    var t = 0
    for(db <- dbs) {
      println(db)
      // TODO get size of snapshot
      println(s"  $db snapshot stores ${db.getAllocatedStorage()} GiB")
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listSQSqueues = {
    val subject = "SQS queues"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val qs = _SQS.get().listQueues().getQueueUrls().asScala
    var t = 0
    for(q <- qs) {
      println(q)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listSESidentities = {
    val subject = "SES email identities"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    var t = 0
    if (List("us-east-1", "us-west=2") contains getRegion) {
      val ids = _SES.get().listIdentities().getIdentities().asScala
      for(id <- ids) {
        println(id)
        t += 1
      }
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }

  def listSNStopics = {
    val subject = "SNS topics"
    val topic = (subject -> Map("account" -> getDomain))
    println( U.header(topic) )
    val topics = _SNS.get().listTopics().getTopics().asScala
    var t = 0
    for(topic <- topics) {
      println(topic)
      t += 1
    }
    println(s"TOTAL $t $subject for account "+getDomain)
    println( U.footer(topic) )            
  }
}

object Accounts {

  def loadToMap(p: Path) = {
    val m = Y.get().load( U.toInputStream(p) ).asInstanceOf[java.util.Map[String,java.util.List[java.util.Map[String,String]]]]
    val top = U.getTopKey(m)
    val lis = m.get(top)
    lis.asScala.map(_.asScala).flatten.toMap +
      ("account_id" -> top) +
      ("domain" -> U.truncExt(p))
  }

  def loadAll(ps: Array[Object]) = {
    for(p <- ps) yield new Account(p.asInstanceOf[Path])
  }
}

object App {

  def getAccountConfs = Files.list( Paths.get( V.creds ) ).toArray

  def main(args: Array[String]) {
    val accts = Accounts.loadAll(getAccountConfs)

    for(acct <- accts) {
      // print account as yaml
      //println( acct.toYaml )

      // list all S3 buckets
      acct.listS3buckets

      // list all EBS volumes
      acct.listEBSvolumes
      // list all EBS snapshots
      acct.listEBSsnapshots

      // list all EC2 instances
      acct.listEC2instances

      // list all ELBs
      acct.listELBinstances

      // list all EFS volumes
      acct.listEFSvolumes

      // list all AMIs
      acct.listAMIs

      // list all Lambda functions
      acct.listLambdaFunctions

      // list all IAM users
      acct.listIAMusers

      // list all IAM groups
      acct.listIAMgroups

      // list all IAM roles
      acct.listIAMroles

      // list all IAM policies
      acct.listIAMpolicies

      // list all security groups
      acct.listSecurityGroups

      // list all subnets
      acct.listSubnets

      // list all Elastic IPs
      acct.listElasticIPs

      // list all VPCs
      acct.listVPCs

      // list all key pairs
      acct.listKeyPairs

      // list all Rte53 hosted zones
      acct.listRt53hostedZones

      // list all ECS clusters
      acct.listECSclusters

      // list all ECR repos
      acct.listECRs

      // list all RDS instances
      acct.listRDSinstances

      // list all SQS
      acct.listSQSqueues

      // list all SES
      acct.listSESidentities

      // list all SNS
      acct.listSNStopics
    }
  }
}
