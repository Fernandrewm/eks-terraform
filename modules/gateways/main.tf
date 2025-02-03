resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Name = "${var.project_name}-igw"
    },
    var.tags
  )
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.project_name}-nat-eip"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_ids[0]

  tags = merge(
    {
      Name = "${var.project_name}-nat-gw"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      Name = "${var.project_name}-public-rt"
    },
    var.tags
  )
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(
    {
      Name = "${var.project_name}-private-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ids)
  subnet_id = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}