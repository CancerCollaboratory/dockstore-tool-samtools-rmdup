#!/usr/bin/env cwl-runner

class: CommandLineTool

description: |
  Usage: samtools index [-bc] [-m INT] <in.bam> [out.index]
  Options:
    -b       Generate BAI-format index for BAM files [default]
    -c       Generate CSI-format index for BAM files
    -m INT   Set minimum interval size for CSI indices to 2^INT [14]

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

