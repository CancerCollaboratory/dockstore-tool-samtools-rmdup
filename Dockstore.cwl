#!/usr/bin/env cwl-runner

class: CommandLineTool

description: |
  Remove potential PCR duplicates: if multiple read pairs have identical external coordinates, only retain the pair with highest mapping quality. In the paired-end mode, this command ONLY works with FR orientation and requires ISIZE is correctly set. It does not work for unpaired reads (e.g. two ends mapped to different chromosomes or orphan reads).

  Usage: samtools rmdup [-sS] <input.srt.bam> <out.bam>
  Options:
    -s       Remove duplicates for single-end reads. By default, the command works for paired-end reads only.
    -S       Treat paired-end reads and single-end reads.

dct:creator:
  foaf:name: Andy Yang
  foaf:mbox: "mailto:ayang@oicr.on.ca"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/cancercollaboratory/dockstore-tool-samtools-rmdup"
  - { import: node-engine.cwl }

inputs:
  - id: "#input"
    type: File
    description: |
      Input bam file.
    inputBinding:
      position: 2

  - id: "#output_name"
    type: string
    inputBinding:
      position: 3

  - id: "#single_end"
    type: boolean
    default: false
    description: |
      rmdup for SE reads

  - id: "#pairend_as_se"
    type: boolean
    default: false
    description: |
      treat PE reads as SE in rmdup (force -s)

outputs:
  - id: "#rmdup"
    type: File
    description: "File with removed duplicates"
    outputBinding:
      glob:
        engine: cwl:JsonPointer
        script: /job/output_name

baseCommand: ["samtools", "rmdup"]

