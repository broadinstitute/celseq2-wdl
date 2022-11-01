version 1.0

workflow call_celseq2 {
  call celseq2
}

task celseq2 {
  input {
    File config
    File table
    String out_dir
    Int threads=16

    Array[File] fastq_files
    File barcode_index
    File annotations
    Array[File] bowtie2_indices 

    String docker_image="us.gcr.io/landerlab-atacseq-200218/landerlab-celseq2:0.2"
    Int memory=64
    Int disk_space=64
    Int num_threads=16
    Int num_preempt=0
  }

  command {
    celseq2 --config-file ${config} \
      --experiment-table ${table} \
      --output-dir ${out_dir} \
      -j ${threads}
    tar czf celseq2_output.tgz ${out_dir}
  }

  runtime {
    docker: docker_image
    memory: "${memory}GB"
    disks: "local-disk ${disk_space} HDD"
    cpu: "${num_threads}"
    preemptible: "${num_preempt}"
  }

  output {
    File out_dir_tgz = "celseq2_output.tgz"
  }
}