### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ c4deb7c8-22c7-49c2-969f-7d5556d4c6a7
using LinearAlgebra, Random

# ╔═╡ 741b7bcc-d2cb-11ee-32fc-93461c4e319c
#Question 4 

# ╔═╡ e3f0b572-ba38-4f99-b6e8-f8e5679ea213
function house(A)
	m = size(A)[1]
	n = size(A)[2]
	W = zeros(m, n)
	E = matrix(1.0I, m , m)
	
	for k in 1:n
		x = A[k:m, k]
		v_k = sign(x[1])*norm(x)*E[k:m,k] + x
		v_k = v_k/norm(v_k)
		W[k:m, k] = v_k
		A[k:m, k] = A[k:m, k] - 2*v_k * (v_k'*A[k:m],k)
	end
	return(W, A[1:n, 1:n])
end

# ╔═╡ 4d6b7096-a125-4a3e-b786-1f53f97c45a8
function formQ(W)
	m = size(W)[1]
	n = size(W)[2]
	E = matrix(1.0I, m, m)
	for k in n:1
		E[k:m] = E[k:m] - 2*W[:,k] * (W[:,k]'*E[k:m])
	end
	return E
end

# ╔═╡ 0a8710dd-efa0-4291-af63-d4bc09ea3980
m = 100

# ╔═╡ 01e39cb8-0bb3-4149-90c4-45d622e5e1f3
U = qr(randn(m)).Q

# ╔═╡ 307f416c-54d9-4b06-88ef-e2a968a09913
V = qr(randn(m)).Q

# ╔═╡ 6f8f6f8b-8399-42c7-a6b2-2ed8aeaeb17f
norm(V' * V - I)

# ╔═╡ bbfefbad-12f2-4388-90ae-2bb44feaf9dc
norm(U' * U - I)

# ╔═╡ 2a32ebc2-6cdb-4583-afee-6b4fd46315c4
s3 = 10 .^ range(1, stop=-25, length=m)

# ╔═╡ 40c2c470-973e-4c45-90d4-7276a606cf0b
A3_CGS = U * Diagonal(s3) * V'

# ╔═╡ 8fa6f3b2-ebcd-41dc-ac39-72da403bd393
#W, R = house(A3_CGS)

# ╔═╡ fab3c8eb-00c7-438a-8eed-b693c5ef0beb
#Q = formQ(W);

# ╔═╡ be310368-ee51-49ed-a84e-4e21c1c59707
#norm(A3 - Q*R)

# ╔═╡ 7ba5c4c2-3f72-469c-b803-f48a66c7a3ab
#norm(Q'*Q - I)


# ╔═╡ 980e6bef-308e-44d9-b263-c4738c767d99
function linsolve_house(A, b)
	m = size(A)[1]
	n = size(A)[2]
	W = zeros(m, n)
	E = matrix(1.0I, m , m)
	
	for k in 1:n
		x = A[k:m, k]
		v_k = sign(x[1])*norm(x)*E[k:m,k] + x
		v_k = v_k/norm(v_k)
		W[k:m, k] = v_k
		A[k:m, k] = A[k:m, k] - 2*v_k * (v_k'*A[k:m],k)

		b[k:m] = b[k:m] - 2*v_k * v_k'*b[k:m] 
		
	end
	return UpperTriangular(A) \ b
end

# ╔═╡ 86d3e8ee-e24f-4493-bc38-ea218c77ee65
begin 
n = 100
A = randn(n, n)
x = ones(n)
b = A * x
x_qr = UpperTriangular(A) \ (b)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
"""

# ╔═╡ Cell order:
# ╠═741b7bcc-d2cb-11ee-32fc-93461c4e319c
# ╠═c4deb7c8-22c7-49c2-969f-7d5556d4c6a7
# ╠═e3f0b572-ba38-4f99-b6e8-f8e5679ea213
# ╠═4d6b7096-a125-4a3e-b786-1f53f97c45a8
# ╠═0a8710dd-efa0-4291-af63-d4bc09ea3980
# ╠═01e39cb8-0bb3-4149-90c4-45d622e5e1f3
# ╠═307f416c-54d9-4b06-88ef-e2a968a09913
# ╠═6f8f6f8b-8399-42c7-a6b2-2ed8aeaeb17f
# ╠═bbfefbad-12f2-4388-90ae-2bb44feaf9dc
# ╠═2a32ebc2-6cdb-4583-afee-6b4fd46315c4
# ╠═40c2c470-973e-4c45-90d4-7276a606cf0b
# ╠═8fa6f3b2-ebcd-41dc-ac39-72da403bd393
# ╠═fab3c8eb-00c7-438a-8eed-b693c5ef0beb
# ╠═be310368-ee51-49ed-a84e-4e21c1c59707
# ╠═7ba5c4c2-3f72-469c-b803-f48a66c7a3ab
# ╠═980e6bef-308e-44d9-b263-c4738c767d99
# ╠═86d3e8ee-e24f-4493-bc38-ea218c77ee65
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
