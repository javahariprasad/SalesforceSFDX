import { LightningElement, api, wire } from 'lwc';
import getPdfFilesWithIdsAsBase64 from '@salesforce/apex/QuoteFileService.getPdfFilesWithIdsAsBase64';
import pdfLib from '@salesforce/resourceUrl/PdfLib';
import { loadScript } from 'lightning/platformResourceLoader';

export default class MergePdfs extends LightningElement {
    @api recordId;
    isLibLoaded = false;
    mergedPdfUrl;
    pdfLibInstance;

    renderedCallback() {
        if (this.isLibLoaded) {
            return;
        }
        loadScript(this, pdfLib + '/pdf-lib.min.js')
            .then(() => {
                if (window['pdfLib'] || window['PDFLib']) {
                    this.isLibLoaded = true;
                    this.pdfLibInstance = window['pdfLib'] || window['PDFLib'];
                    this.loadPdfs();
                } else {
                    console.error('PDF-LIB not loaded correctly.');
                }
            })
            .catch(error => {
                console.error('Error loading PDF-LIB:', error);
            });
    }

    @wire(getPdfFilesWithIdsAsBase64, { opportunityId: '$recordId' })
    wiredPdfs({ error, data }) {
        if (this.isLibLoaded && data) {
            this.mergePDFs(data);
        } else if (error) {
            console.error('Error fetching PDFs:', error);
        }
    }

    async mergePDFs(pdfFiles) {
        if (!this.pdfLibInstance) {
            console.error('PDF-LIB instance is not defined.');
            return;
        }

        const { PDFDocument } = this.pdfLibInstance;

        const mergedPdf = await PDFDocument.create();
        for (let pdfFile of pdfFiles) {
            const pdfBytes = Uint8Array.from(atob(pdfFile.Base64Data), c => c.charCodeAt(0));
            const pdfDoc = await PDFDocument.load(pdfBytes);
            const copiedPages = await mergedPdf.copyPages(pdfDoc, pdfDoc.getPageIndices());
            copiedPages.forEach(page => mergedPdf.addPage(page));
        }

        const mergedPdfBytes = await mergedPdf.save();
        this.mergedPdfUrl = URL.createObjectURL(new Blob([mergedPdfBytes], { type: 'application/pdf' }));
    }
}