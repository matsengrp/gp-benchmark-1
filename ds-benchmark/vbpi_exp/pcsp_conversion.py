#!/usr/bin/env python
import click

# The three use different taxon orders, but follow the convention for PCSPs of 
# sister|focal|child, using the smaller child. This code works with strings of bits, 
# without the separating vertical bar.

gp_taxon_order = {
        "ds1":[1,24,10,22,25,7,11,16,20,18,12,4,17,6,8,13,9,3,14,19,21,5,2,23,26,27,15],
        "ds2":[],
        "ds3":[1,31,14,2,34,8,10,35,4,12,15,30,32,19,3,11,18,13,16,9,36,33,20,23,25,26,27,28,24,21,22,29,5,17,6,7],
        "ds4":[1,4,11,10,22,37,9,14,36,41,17,31,32,2,23,33,6,13,7,15,16,39,18,27,28,19,20,3,35,21,29,26,40,30,38,12,24,34,5,25,8],
        "ds5":[1,10,39,36,5,27,45,35,24,13,34,47,48,12,33,38,30,4,43,32,11,15,50,8,25,40,7,14,49,20,42,22,28,46,17,6,23,9,31,16,21,18,19,41,44,26,37,29,2,3],
        "ds6":[1,46,10,38,47,9,13,14,22,3,23,31,48,16,42,17,19,43,26,27,32,44,4,18,2,20,21,35,5,24,34,33,45,39,40,11,28,29,37,12,25,36,41,7,8,15,30,49,50,6],
        "ds7":[1,53,20,2,56,8,16,4,57,18,21,52,54,25,3,10,11,9,14,15,12,13,19,22,58,59,26,29,27,28,32,33,43,44,30,31,47,48,49,50,45,46,34,35,36,37,38,39,40,42,41,51,5,55,23,17,24,6,7],
        "ds8":[1,17,18,19,32,33,34,37,51,7,15,60,61,11,12,16,50,3,27,29,58,59,30,31,28,13,8,35,39,40,44,45,63,64,55,62,9,38,14,2,54,36,20,25,26,56,57,21,23,22,24,47,48,49,52,53,42,43,46,10,6,41,5,4]
}

taxon_count = {ds: len(gp_taxon_order[ds]) for ds in gp_taxon_order}
rimu_taxon_order = {ds: list(range(1, taxon_count[ds] + 1)) for ds in taxon_count}        
vbpi_taxon_order ={
    "ds1":[15,18,20,16,11,25,7,22,10,24,1,27,5,21,19,14,13,9,3,26,23,2,8,17,6,12,4],
    "ds2":[],
    "ds3":[7,6,19,32,30,15,12,3,10,35,4,34,8,2,14,31,1,18,11,17,36,33,16,13,9,5,29,22,21,24,28,27,26,25,23,20],
    "ds4":[8,25,24,12,34,5,38,30,11,4,1,39,16,15,40,28,27,18,26,29,21,20,19,35,3,13,7,37,22,10,9,33,6,32,31,17,41,36,14,23,2],
    "ds5":[1,3,2,31,23,9,46,28,22,42,20,49,14,17,6,11,15,50,8,25,40,7,32,38,33,12,48,47,34,13,24,35,45,27,39,10,36,5,30,43,4,19,18,41,44,29,37,26,21,16],
    "ds6":[6,46,1,50,49,30,15,10,47,38,9,37,29,28,11,25,12,41,36,8,7,40,39,45,33,34,24,48,31,23,22,14,13,42,16,3,21,35,5,20,27,26,19,43,17,18,44,32,4,2],
    "ds7":[7,6,25,54,52,21,18,3,57,16,4,56,8,2,20,53,1,24,17,23,51,41,42,40,39,38,37,36,35,34,46,45,50,49,48,47,31,30,44,43,33,32,29,28,27,26,5,55,59,58,22,19,14,15,13,12,10,11,9],
    "ds8":[4,5,41,46,43,42,53,52,49,48,47,24,22,23,21,57,56,26,25,20,36,28,31,30,59,58,29,27,50,16,12,11,3,38,62,55,9,64,63,45,44,40,39,35,13,8,54,14,2,61,60,15,37,51,34,33,32,19,7,18,17,1,10,6]
}

gp_to_rimu = {ds: [gp_taxon_order[ds].index(taxon) for taxon in rimu_taxon_order[ds]] for ds in gp_taxon_order}
gp_to_vbpi = {ds: [gp_taxon_order[ds].index(taxon) for taxon in vbpi_taxon_order[ds]] for ds in gp_taxon_order}
rimu_to_gp = {ds: [rimu_taxon_order[ds].index(taxon) for taxon in gp_taxon_order[ds]] for ds in rimu_taxon_order}
rimu_to_vbpi = {ds: [rimu_taxon_order[ds].index(taxon) for taxon in vbpi_taxon_order[ds]] for ds in rimu_taxon_order}
vbpi_to_gp = {ds: [vbpi_taxon_order[ds].index(taxon) for taxon in gp_taxon_order[ds]] for ds in vbpi_taxon_order}
vbpi_to_rimu = {ds: [vbpi_taxon_order[ds].index(taxon) for taxon in rimu_taxon_order[ds]] for ds in vbpi_taxon_order}
type_to_type = {
    "gp": {"rimu": gp_to_rimu, "vbpi": gp_to_vbpi},
    "rimu": {"gp": rimu_to_gp, "vbpi": rimu_to_vbpi},
    "vbpi": {"gp": vbpi_to_gp, "rimu": vbpi_to_rimu}
}


def convert_pcsp(pcsp_string, input="rimu", output="gp", ds="ds1"):
    """
    Take a PCSP with sister|focal|child (as a string of 0's and 1's, no |'s) with the input
    taxon ordering and return one with the output taxon ordering, for the given DS dataset.
    """
    input_to_output = type_to_type[input][output][ds]
    mid_point = taxon_count[ds]
    clade_reorder = lambda bits: "".join([bits[input_to_output[j]] for j in range(mid_point)])
    choice = lambda p, c: min(c, bin(int(p, 2) & ~int(c, 2))[2:].zfill(mid_point))
    if len(pcsp_string) == mid_point:
        return clade_reorder(pcsp_string)
    else:
        sister = clade_reorder(pcsp_string[:mid_point])
        focal = clade_reorder(pcsp_string[mid_point : 2 * mid_point])
        child = clade_reorder(pcsp_string[2 * mid_point :])
        return sister + focal + choice(focal, child)


def new_to_old(new_taxon_list, pcsp_string, ds="ds1"):
    input_to_output = [new_taxon_list.index(taxon) for taxon in gp_taxon_order[ds]]
    mid_point = taxon_count[ds]
    clade_reorder = lambda bits: "".join([bits[input_to_output[j]] for j in range(mid_point)])
    choice = lambda p, c: min(c, bin(int(p, 2) & ~int(c, 2))[2:].zfill(mid_point))
    if len(pcsp_string) == mid_point:
        return clade_reorder(pcsp_string)
    else:
        sister = clade_reorder(pcsp_string[:mid_point])
        focal = clade_reorder(pcsp_string[mid_point : 2 * mid_point])
        child = clade_reorder(pcsp_string[2 * mid_point :])
        return sister + focal + choice(focal, child)

def old_to_new(new_taxon_list, pcsp_string, ds="ds1"):
    input_to_output = [gp_taxon_order[ds].index(taxon) for taxon in new_taxon_list]
    mid_point = taxon_count[ds]
    clade_reorder = lambda bits: "".join([bits[input_to_output[j]] for j in range(mid_point)])
    choice = lambda p, c: min(c, bin(int(p, 2) & ~int(c, 2))[2:].zfill(mid_point))
    if len(pcsp_string) == mid_point:
        return clade_reorder(pcsp_string)
    else:
        sister = clade_reorder(pcsp_string[:mid_point])
        focal = clade_reorder(pcsp_string[mid_point : 2 * mid_point])
        child = clade_reorder(pcsp_string[2 * mid_point :])
        return sister + focal + choice(focal, child)





@click.command()
@click.argument("pcsp_string")
@click.option("--input", default="rimu")
@click.option("--output", default="gp")
@click.option("--ds", default="ds1")
def wrapper_for_shell_call(pcsp_string, input="rimu", output="gp", ds="ds1"):
    click.echo(convert_pcsp(pcsp_string, input, output, ds))


if __name__=="__main__":
    wrapper_for_shell_call()
