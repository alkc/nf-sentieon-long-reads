

workflow {

    ch_samplesheet = Channel.empty()
    NF_SENTIEON_LONGREAD(ch_samplesheet)
}

workflow NF_SENTIEON_LONGREAD {

    take:
    ch_samplesheet

    main:
    // COPY-BAM step?
    /* DNASCOPE WORKFLOW */
    // 1. SPLIT BED PRIOR TO DNASCOPE
    //    i.e. split calling across multiple processes. split diploid bed? haploid calling own process?
    // 2. DNASCOPE SNV INDEL CALLING
    // 3. GLUE SHARDS TOGETHER

    /* OTHER WORKFLOWS: */
    // LONGREADSV
    // HIFI CNV
    // QC

    output:
    bam_bai = ch_bam_bai
    snv_indels_vcf = ch_snv_indels
    sv_vcf = ch_sv_vcf
    versions = ch_versions
}

process DNASCOPE {

}

process DNASCOPEHP {

}


process HIFICNV {

}

process LONGREADSV {

    input:
    tuple meta bam bai

    output:
    tuple meta sv_vcf sv_vcf_tbi

    script:
    """
    sentieon driver \\
    --input $bam \\
    --reference ${params.fasta} \\
    --thread_count ${task.cpus} \\
    --interval_padding 0 \\
    --algo LongReadSV \\
    --model ${params.longread_model}
    ${meta.id}.sv.vcf.gz
    """

}

process MOSDEPTH {

}

process VCF_MOD {

}
