terraform {
  cloud {
    organization = "FIAP-Lanchonete-G41"

    workspaces {
      name = "tech-challenge-fase-3-db"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
