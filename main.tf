module "network" {
  source = "../MODULE"
}


resource "google_compute_firewall" "ouv" {
  name       = "test1-firewall"
  network    = module.network.vpc
  #subnetwork = google_compute_subnetwork.public-subnetwork.name
  direction  = "EGRESS"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["5011"]
  }

}

# ##################
# resource "google_compute_instance" "vmhayet" {
#   boot_disk {
#     auto_delete = true
#     device_name = "vmhayet"

#     initialize_params {
#       image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230615"
#       size  = 10
#       type  = "pd-balanced"
#     }

#     mode = "READ_WRITE"
#   }

#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false

#   labels = {
#     goog-ec-src = "vm_add-tf"
#   }

#   machine_type = "e2-medium"
#   name         = "vmhayet"

#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }

#     subnetwork = "projects/yefsah-hayet/regions/europe-north1/subnetworks/default"
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     provisioning_model  = "STANDARD"
#   }

#   service_account {
#     email  = "657990065782-compute@developer.gserviceaccount.com"
#     scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
#   }

#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = false
#     enable_vtpm                 = true
#   }

#   tags = ["http-server", "https-server"]
#   zone = "europe-north1-a"
# }






resource "google_compute_firewall" "fer" {
  name    = "test2-firewall"
  network = module.network.vpc
  direction               = "INGRESS"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  allow {
    protocol = "tcp"
    ports    = ["5011"]
  }
}


data "template_cloudinit_config" "user_data" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = file("deploy.sh")
    filename = "deploy.sh"
  }
}

# # }



resource "google_compute_instance" "instance" {
  name         = "hayetinstance"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }

    }
  }
  network_interface {
    network    = module.network.vpcnet
    subnetwork = module.network.subnet
    access_config {

    }
  }
  # metadata = {
    
  
  #   user-data   = data.template_cloudinit_config.user_data.rendered
  # }
   metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip rsync; pip install flask"

  # metadata = {
  #       startup-script = <<SCRIPT
  #       apt-get -y update
  #       apt-get -y install nginx
  #       export HOSTNAME=$(hostname | tr -d '\n')
  #       export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
  #       echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
  #       service nginx start
  #       SCRIPT
  #   } 
#   metadata = {
#     ssh-keys = <<EOF
# hayet_yefsah : ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7zmcbA+24AYvb7Jl9g1FDznx+Ve9ik5BenPtGXJUuciKBWiVmQwFv2WNl6JrzlE9cvsMazOiOTqS3VtYbW4UKodz5YMUcTqRJsm5lmeROY6pOg3e7bS0ZrPiUoQldeizYMByt7kfu3fUxZ2uS3v6dC9E53R7ofvTqfhEg5jqjA1vF291+2YA7Ek39S8Cu/9gvTNAbvRgG6LL9k+a3gRJN9URsA1ljnHn5S1XEVdUi+rkBGJTyW96pXERy2iCW4STU2w4A5Wi1yYye04t+IGVUB9OgF0jDx5x68cbP+3hEhwH3UTFexEtnKvGHBYtxGzDAs/3KRq96eU1nKEHSJkswupMioZpFmOooci2PhZZz1jzqBbbaqk7L/R0C9qOOAy63to4Ef2bqbtHxhoAQUi390qVWkpfWt9SdLn6QtH6DmSXYU/nKH2qsGz+s8KWaRs6craVp3eW8sdURiOLcWZ+fryXQChupBTgn829iWZFqLkRZob9qxR0yjMKqj9vibk0= hayet_yefsah@cs-873029276819-default

#     EOF
#   }

  # provisioner "file" {
  #   source      = "C:\\Users\\hayet\\Documents\\terraform_zenika\\deploy.sh"
  #   destination = "/tmp/deploy.sh"
  #   connection {
  #     type        = "ssh"
  #     user        = "hayet_yefsah"
  #     private_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7zmcbA+24AYvb7Jl9g1FDznx+Ve9ik5BenPtGXJUuciKBWiVmQwFv2WNl6JrzlE9cvsMazOiOTqS3VtYbW4UKodz5YMUcTqRJsm5lmeROY6pOg3e7bS0ZrPiUoQldeizYMByt7kfu3fUxZ2uS3v6dC9E53R7ofvTqfhEg5jqjA1vF291+2YA7Ek39S8Cu/9gvTNAbvRgG6LL9k+a3gRJN9URsA1ljnHn5S1XEVdUi+rkBGJTyW96pXERy2iCW4STU2w4A5Wi1yYye04t+IGVUB9OgF0jDx5x68cbP+3hEhwH3UTFexEtnKvGHBYtxGzDAs/3KRq96eU1nKEHSJkswupMioZpFmOooci2PhZZz1jzqBbbaqk7L/R0C9qOOAy63to4Ef2bqbtHxhoAQUi390qVWkpfWt9SdLn6QtH6DmSXYU/nKH2qsGz+s8KWaRs6craVp3eW8sdURiOLcWZ+fryXQChupBTgn829iWZFqLkRZob9qxR0yjMKqj9vibk0= hayet_yefsah@cs-873029276819-default"
  #      host   = google_compute_instance.instance.network_interface[0].access_config[0].nat_ip
  #   }

  # }



#   provisioner "remote-exec" {
#   inline = [
#     "chmod +x /tmp/deploy.sh",
#     "cd /tmp",
#     "./deploy.sh"
#   ]

# # #   # connection {
# # #   #         type = "ssh"
# # #   #         user = "hayet_yefsah"
# # #   #         private_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7zmcbA+24AYvb7Jl9g1FDznx+Ve9ik5BenPtGXJUuciKBWiVmQwFv2WNl6JrzlE9cvsMazOiOTqS3VtYbW4UKodz5YMUcTqRJsm5lmeROY6pOg3e7bS0ZrPiUoQldeizYMByt7kfu3fUxZ2uS3v6dC9E53R7ofvTqfhEg5jqjA1vF291+2YA7Ek39S8Cu/9gvTNAbvRgG6LL9k+a3gRJN9URsA1ljnHn5S1XEVdUi+rkBGJTyW96pXERy2iCW4STU2w4A5Wi1yYye04t+IGVUB9OgF0jDx5x68cbP+3hEhwH3UTFexEtnKvGHBYtxGzDAs/3KRq96eU1nKEHSJkswupMioZpFmOooci2PhZZz1jzqBbbaqk7L/R0C9qOOAy63to4Ef2bqbtHxhoAQUi390qVWkpfWt9SdLn6QtH6DmSXYU/nKH2qsGz+s8KWaRs6craVp3eW8sdURiOLcWZ+fryXQChupBTgn829iWZFqLkRZob9qxR0yjMKqj9vibk0= hayet_yefsah@cs-873029276819-default"

#       }

# #   # }
}





# # output "ip" {
# #   value = google_compute_instance.instance.network_interface.0.network_ip
# # }







# # provisioner "file" {
# # source = "deploy.sh"
# # destination = "/tmp/deploy.sh"
# # connection {
# #     type = "ssh"
# #     user = var.user
# #     private_key = file(var.privatekeypath)
# # }
# # }
# # provisioner "remote-exec" {
# # inline = [
# #   "chmod +x /tmp/autoo.sh",
# #   "cd /tmp",
# #   "./autoo.sh"
# # ]
# # connection {
# #     type = "ssh"
# #     user = var.user
# #     private_key = file(var.privatekeypath)
# # }






# resource "google_compute_instance" "vmhayet" {
#   boot_disk {
#     auto_delete = true
#     device_name = "vmhayet"

#     initialize_params {
#       image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230615"
#       size  = 10
#       type  = "pd-balanced"
#     }

#     mode = "READ_WRITE"
#   }

#   can_ip_forward      = false
#   deletion_protection = false
#   enable_display      = false

#   labels = {
#     goog-ec-src = "vm_add-tf"
#   }

#   machine_type = "e2-medium"
#   name         = "vmhayet"

#   network_interface {
#     access_config {
#       network_tier = "PREMIUM"
#     }

#     subnetwork = "projects/yefsah-hayet/regions/europe-north1/subnetworks/default"
#   }

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     #provisioning_model  = "STANDARD"
#   }

#   service_account {
#     email  = "657990065782-compute@developer.gserviceaccount.com"
#     scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
#   }

#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = false
#     enable_vtpm                 = true
#   }

#   tags = ["http-server", "https-server"]
#   zone = "europe-north1-a"
# }