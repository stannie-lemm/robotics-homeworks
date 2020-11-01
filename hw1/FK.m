%% FK

function fk = FK(q1, q2, q3, q4, q5, q6)
l0 = 670; l1 = 312; l2 = 1075; l3 = 225; l4 = 1280; l5 = 215;
dl = sqrt(l3^2 + l4^2)
dq = atan2(l4, l3)

fk = RTmatrices.Tz(l0)*RTmatrices.Rz(q1)*RTmatrices.Tx(l1)*RTmatrices.Ry(q2)*RTmatrices.Tx(l2)*RTmatrices.Ry(q3 + dq)*RTmatrices.Tx(dl)*RTmatrices.Ry(-dq)*RTmatrices.Rx(q4)*RTmatrices.Ry(q5)*RTmatrices.Rx(q6)*RTmatrices.Tx(l5)
end