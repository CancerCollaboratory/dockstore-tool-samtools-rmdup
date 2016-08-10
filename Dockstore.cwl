#!/usr/bin/env cwl-runner

class: CommandLineTool

dct:contributor:
  foaf:name: Andy Yang
  foaf:mbox: mailto:ayang@oicr.on.ca
dct:creator:
  '@id': http://orcid.org/0000-0001-9102-5681
  foaf:name: Andrey Kartashov
  foaf:mbox: mailto:Andrey.Kartashov@cchmc.org
dct:description: 'Developed at Cincinnati Children’s Hospital Medical Center for the
  CWL consortium http://commonwl.org/ Original URL: https://github.com/common-workflow-language/workflows'
cwlVersion: v1.0

requirements:
- class: DockerRequirement
  dockerPull: quay.io/cancercollaboratory/dockstore-tool-samtools-rmdup
inputs:
  single_end:
    type: boolean
    default: false
    doc: |
      rmdup for SE reads
  input:
    type: File
    inputBinding:
      position: 2

    doc: |
      Input bam file.
  output_name:
    type: string
    inputBinding:
      position: 3

  pairend_as_se:
    type: boolean
    default: false
    doc: |
      treat PE reads as SE in rmdup (force -s)
outputs:
  rmdup:
    type: File
    outputBinding:
      glob: $(inputs.output_name)

    doc: File with removed duplicates
baseCommand: [samtools, rmdup]
doc: |
  Remove potential PCR duplicates: if multiple read pairs have identical external coordinates, only retain the pair with highest mapping quality. In the paired-end mode, this command ONLY works with FR orientation and requires ISIZE is correctly set. It does not work for unpaired reads (e.g. two ends mapped to different chromosomes or orphan reads).

  Usage: samtools rmdup [-sS] <input.srt.bam> <out.bam>
  Options:
    -s       Remove duplicates for single-end reads. By default, the command works for paired-end reads only.
    -S       Treat paired-end reads and single-end reads.

